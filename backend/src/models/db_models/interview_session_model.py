from uuid import UUID
from uuid import uuid4
from sqlalchemy import String, ForeignKey
from typing import Any, Dict, List, Optional, Tuple
from sqlalchemy.orm import mapped_column, Mapped, relationship
from sqlalchemy import DateTime
from datetime import datetime
from pydantic import BaseModel, Field
from src.models.db_models.base_model import EntityBaseModel
from src.models.db_models.interview_question_model import InterviewQuestion, InterviewQuestionModel,  InterviewQuestionModel
from src.models.db_models.interview_question_group_model import InterviewQuestionGroup, InterviewQuestionGroupModel
from src.models.db_models.interview_record_model import InterviewRecordModel
from src.models.db_models.teacher_model import Teacher
from src.models.db_models.user_model import User
from src.models.app_pydantic_base_model import AppPydanticBaseModel
from src.models.error_models.interview_has_already_ended_exception import InterviewHasAlreadyEndedException
from sqlalchemy.orm import Session


class InterviewSession(AppPydanticBaseModel):
    id: UUID
    user_id: UUID
    user: Optional[User] = Field(None)
    teacher_id: UUID
    teacher: Optional[Teacher] = Field(None)
    start_at: datetime
    current_question_id: UUID
    current_question: Optional[InterviewQuestion] = Field(None)
    done: bool


class InterviewSessionModel(EntityBaseModel):
    __tablename__ = "InterviewSessions"
    id: Mapped[UUID] = mapped_column(primary_key=True)
    user_id: Mapped[UUID] = mapped_column(
        ForeignKey("Users.id", ondelete="CASCADE"))
    user = relationship(
        "UserModel", backref="interview_sessions", cascade="all, delete")
    teacher_id: Mapped[UUID] = mapped_column(ForeignKey("Teachers.id"))
    teacher = relationship("TeacherModel", backref="interview_sessions")
    start_at: Mapped[datetime] = mapped_column(type_=DateTime(timezone=True))
    current_question_id: Mapped[UUID] = mapped_column(
        ForeignKey("InterviewQuestions.id"))
    current_question: Mapped[Optional[InterviewQuestionModel]] = relationship(
        "InterviewQuestionModel", back_populates="interview_sessions")
    done: Mapped[bool]

    def progress_interview(
            self,
            db_session: Session,
            extracted_value: Any,
            interview_groups: List[InterviewQuestionGroupModel],
            questions_by_group: Dict[UUID, List[InterviewQuestionModel]], records: List[InterviewRecordModel]):
        """面談の質問を進行させます。

        `src/usecases/interview/speak_to_teacher.py`から呼び出す事を想定しています。

        Args:
            db_session (Session): DBセッション
            extracted_value (Any): 抽出された値
            questions_by_group (Dict[UUID, List[InterviewQuestionModel]]): キーがグループID、値が質問のリストの辞書
        Returns:


        Raises:
            ValueError
        """
        if not self.current_question:
            raise ValueError("The current question is not loaded.")
        if self.done:
            raise InterviewHasAlreadyEndedException(
                "This interview has already ended.")

        # InterviewRecordに記録する
        interview_record = InterviewRecordModel(
            id=uuid4(),
            session_id=self.id,
            question_id=self.current_question.id,
            extracted_data=str(extracted_value)
        )
        db_session.add(interview_record)
        db_session.commit()
        (previous_value, previous_value_type) = self._get_previous_extracted_value(
            interview_groups, questions_by_group, records)
        self._move_on_next_question(
            db_session, interview_groups, questions_by_group, previous_value, previous_value_type)

    def _get_next_question(self, interview_groups: List[InterviewQuestionGroupModel], questions_by_group: Dict[UUID, List[InterviewQuestionModel]]) -> Optional[InterviewQuestionModel]:
        """次の質問のInterviewQuestionを取得します。

        Args:
            questions_by_group (Dict[UUID, List[InterviewQuestionModel]]): キーがグループID、値が質問のリストの辞書

        Returns:
            UUID: 次の質問のID

        Raises:
            ValueError
        """
        if not self.current_question:
            raise ValueError("The current question is not loaded.")
        questions_in_group = questions_by_group[self.current_question.group_id]
        if self.current_question.order == len(questions_in_group):
            # QuestionGroup内の最後の質問だった場合
            next_question_group_order = None
            for group in interview_groups:
                questions = questions_by_group[group.id]
                for q in questions:
                    if q.id == self.current_question.id:
                        next_question_group_order = group.order + 1
                        break
            if next_question_group_order is None:
                raise ValueError("Couldn't find next questoin group order.")

            if next_question_group_order > len(interview_groups):
                # 最後のQuestionGroupの最後のInterviewQuestionだった場合
                return None

            # 次のQuestionGroupの最初のInterviewQuestionを取得
            next_question_group: Optional[InterviewQuestionGroupModel] = None
            for group in interview_groups:
                if group.order == next_question_group_order:
                    next_question_group = group
                    break

            if not next_question_group:
                raise ValueError("The next question group is not found.")

            questions_in_next_group = questions_by_group[next_question_group.id]
            questions_in_next_group.sort(key=lambda q: q.order)

            fist_question_in_group = questions_in_next_group[0]

            return fist_question_in_group
        else:
            # 同じQuestionGroup内の次の質問を取得
            questions_in_group.sort(key=lambda q: q.order)
            return questions_in_group[self.current_question.order]

    def _move_on_next_question(self, db_session: Session,
                               interview_groups: List[InterviewQuestionGroupModel],
                               questions_by_group: Dict[UUID, List[InterviewQuestionModel]],
                               previous_extracted_value: Optional[str],
                               previous_extracted_value_type: Optional[str]
                               ):
        """このInterviewSessionの現在の質問を次に進めます。

        (progress_interview()から呼び出される事を想定しています。)

        Args:
            db_session (Session): DBセッション
            interview_groups (List[InterviewQuestionGroup]): InterviewQuestionGroupのリスト
            questions_by_group (Dict[UUID, List[InterviewQuestionModel]]): キーがグループID、値がInterviewQuestionのリストの辞書
            previous_question_extracted_value (Optional[str]): 前の質問の抽出された値
        Returns:

        Raises:
        """

        next_question: Optional[InterviewQuestionModel] = self._get_next_question(
            interview_groups,
            questions_by_group
        )

        if next_question:
            self.current_question_id = next_question.id
            self.current_question = next_question
        else:
            # 最後の質問だった場合
            self.done = True

        if (
            next_question and
            previous_extracted_value and
            previous_extracted_value_type and
            next_question.has_condition() and
            next_question.can_skip(
                previous_extracted_value, previous_extracted_value_type
            )
        ):
            # TODO: この実装だと1個次の質問しかスキップできないため、複数先の質問をスキップできるようにする。（2024/11/30現段階では要件にないため問題ない。）
            next_question = self._get_next_question(
                interview_groups, questions_by_group
            )

        db_session.add(self)
        db_session.commit()
        return next_question

    def _get_previous_extracted_value(
        self,
        interview_groups: List[InterviewQuestionGroupModel],
        questions_by_group: Dict[UUID, List[InterviewQuestionModel]],
        records: List[InterviewRecordModel]
    ) -> Tuple[Optional[str], Optional[str]]:
        """前の質問の抽出された値を取得します。
        Args:
            db_session (Session): DBセッション
            interview_groups (List[InterviewQuestionGroup]): InterviewQuestionGroupのリスト
            questions_by_group (Dict[UUID, List[InterviewQuestionModel]]): キーがグループID、値がInterviewQuestionのリストの辞書
            records (List[InterviewRecordModel]): InterviewRecordのリスト

        Returns:
            (Optional[str], Optional[str]): 前の質問の抽出された値, 前の質問の抽出された値のデータ型
        Raises:
        """
        previous_question: Optional[InterviewQuestionModel] = None
        previous_question_found = False
        # TODO: ソートはCRUDで行うべき
        interview_groups.sort(key=lambda g: g.order)
        for g in interview_groups:
            questions = questions_by_group[g.id]
            questions.sort(key=lambda q: q.order)
            for q in questions:
                if q.id == self.current_question_id:
                    previous_question_found = True
                    break
                previous_question = q
            if previous_question_found:
                break
        if previous_question is None:
            return (None, None)
        for r in records:
            if r.session_id == self.id and r.question_id == previous_question.id:
                return (r.extracted_data, previous_question.extraction_data_type)
        return (None, None)


class InterviewSessionUpdate(AppPydanticBaseModel):
    user_id: UUID
    teacher_id: UUID
    start_at: datetime
    progress: int
    done: bool
