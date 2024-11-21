from uuid import UUID
from sqlalchemy import String, ForeignKey
from typing import List, Optional
from sqlalchemy.orm import mapped_column, Mapped, relationship
from sqlalchemy import DateTime
from datetime import datetime
from pydantic import BaseModel, Field
from src.models.db_models.base_model import EntityBaseModel
from src.models.db_models.interview_question_model import InterviewQuestion, InterviewQuestionModel
from src.models.db_models.teacher_model import Teacher
from src.models.db_models.user_model import User
from src.models.app_pydantic_base_model import AppPydanticBaseModel


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


class InterviewSessionUpdate(AppPydanticBaseModel):
    user_id: UUID
    teacher_id: UUID
    start_at: datetime
    progress: int
    done: bool
