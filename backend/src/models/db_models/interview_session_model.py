from uuid import UUID
from src.models import EntityBaseModel, User, Teacher
from sqlalchemy import String, ForeignKey
from typing import List, Optional
from sqlalchemy.orm import mapped_column, Mapped, relationship
from sqlalchemy import DateTime
from datetime import datetime
from pydantic import BaseModel, Field
from src.models.app_pydantic_base_model import AppPydanticBaseModel


class InterviewSession(AppPydanticBaseModel):
    id: UUID
    user_id: UUID
    user: Optional[User] = Field(None)
    teacher_id: UUID
    teacher: Optional[Teacher] = Field(None)
    start_at: datetime
    progress: int
    done: bool


class InterviewSessionModel(EntityBaseModel):
    __tablename__ = "InterviewSessions"
    id: Mapped[UUID] = mapped_column(primary_key=True)
    user_id: Mapped[UUID] = mapped_column(ForeignKey("Users.id"))
    user = relationship("UserModel", backref="interview_sessions")
    teacher_id: Mapped[UUID] = mapped_column(ForeignKey("Teachers.id"))
    teacher = relationship("TeacherModel", backref="interview_sessions")
    start_at: Mapped[datetime] = mapped_column(type_=DateTime(timezone=True))
    progress: Mapped[int] = mapped_column(
        ForeignKey("InterviewQuestions.order"))
    done: Mapped[bool]


class InterviewSessionUpdate(AppPydanticBaseModel):
    user_id: UUID
    teacher_id: UUID
    start_at: datetime
    progress: int
    done: bool
