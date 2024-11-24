from uuid import UUID
from sqlalchemy import String, ForeignKey
from typing import Any, Dict, List, Optional
from sqlalchemy.orm import mapped_column, Mapped, relationship
from sqlalchemy import DateTime
from datetime import datetime
from pydantic import BaseModel, Field
from src.models.db_models.base_model import EntityBaseModel
from src.models.db_models.interview_question_model import InterviewQuestion, InterviewQuestionModel
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

    def update_interview_progress(self, db_session: Session, extracted_value: Any, questions_by_group: Dict[UUID, List[InterviewQuestionModel]]):
        if not self.current_question:
            raise ValueError("The current question is not loaded.")
        if self.done:
            raise InterviewHasAlreadyEndedException(
                "This interview has already ended.")
        if not self.current_question.validate_answer(db_session, extracted_value):
            raise ValueError("The answer is invalid.")

        questions_in_group = questions_by_group[self.current_question.group_id]
        questions_in_group.sort(key=lambda q: q.order)  # 昇順にソート

        current_question_index: Optional[int] = None
        for i, q in enumerate(questions_in_group):
            if q.id == self.current_question_id:
                current_question_index = i
                break

        # TODO: InterviewRecordに記録する

        if current_question_index is None:
            raise ValueError("The current question is not in the group.")

        if current_question_index == len(questions_in_group) - 1:
            # QuestionGroup内の最後の質問だった場合
            pass
        else:
            next_question = questions_in_group[current_question_index + 1]
            self.current_question_id = next_question.id
            db_session.add(self)
            db_session.commit()


class InterviewSessionUpdate(AppPydanticBaseModel):
    user_id: UUID
    teacher_id: UUID
    start_at: datetime
    progress: int
    done: bool
