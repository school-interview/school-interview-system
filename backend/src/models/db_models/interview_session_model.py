from uuid import UUID
from uuid import uuid4
from sqlalchemy import String, ForeignKey
from typing import Any, Dict, List, Optional
from sqlalchemy.orm import mapped_column, Mapped, relationship
from sqlalchemy import DateTime
from datetime import datetime
from pydantic import BaseModel, Field
from src.models.db_models.base_model import EntityBaseModel
from src.models.db_models.interview_question_model import InterviewQuestion, InterviewQuestionModel
from src.models.db_models.interview_question_group_model import InterviewQuestionGroup
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

    def progress_interview(self, db_session: Session, extracted_value: Any, interview_groups: List[InterviewQuestionGroup], questions_by_group: Dict[UUID, List[InterviewQuestion]]):
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
        if self.current_question.can_skip(extracted_value):
            self._move_on_next_question(
                db_session, interview_groups, questions_by_group)
            return

        # InterviewRecordに記録する
        interview_record = InterviewRecordModel(
            id=uuid4(),
            session_id=self.id,
            question_id=self.current_question.id,
            extracted_value=str(extracted_value)
        )
        db_session.add(interview_record)

        self._move_on_next_question(
            db_session, interview_groups, questions_by_group)

    def _get_next_question(self, interview_groups: List[InterviewQuestionGroup], questions_by_group: Dict[UUID, List[InterviewQuestion]]) -> Optional[InterviewQuestion]:
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
            next_question_group_order = self.current_question.order + 1
            if next_question_group_order >= len(interview_groups):
                # 最後のQuestionGroupの最後のInterviewQuestionだった場合
                return None

            # 次のQuestionGroupの最初のInterviewQuestionを取得
            next_question_group: Optional[InterviewQuestionGroup] = None
            for group in interview_groups:
                if group.order == next_question_group_order:
                    next_question_group = group
                    break

            if not next_question_group:
                raise ValueError("The next question group is not found.")

            fist_question_in_group = questions_by_group[next_question_group.id][0]
            return fist_question_in_group
        else:
            # 同じQuestionGroup内の次の質問を取得
            return questions_in_group[self.current_question.order]

    def _move_on_next_question(self, db_session: Session, interview_groups: List[InterviewQuestionGroup], questions_by_group: Dict[UUID, List[InterviewQuestion]]):
        """このInterviewSessionの現在の質問を次に進めます。

        Args:
            db_session (Session): DBセッション
            interview_groups (List[InterviewQuestionGroup]): InterviewQuestionGroupのリスト
            questions_by_group (Dict[UUID, List[InterviewQuestionModel]]): キーがグループID、値がInterviewQuestionのリストの辞書

        Returns:

        Raises:
        """
        next_question: Optional[InterviewQuestion] = self._get_next_question(
            interview_groups, questions_by_group)
        if next_question:
            self.current_question_id = next_question.id
        else:
            # 最後の質問だった場合
            self.done = True

        db_session.add(self)
        db_session.commit()


class InterviewSessionUpdate(AppPydanticBaseModel):
    user_id: UUID
    teacher_id: UUID
    start_at: datetime
    progress: int
    done: bool
