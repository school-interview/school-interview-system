from uuid import UUID
from src.models import BaseModel
from sqlalchemy import String, ForeignKey
from typing import List
from sqlalchemy.orm import mapped_column, Mapped, relationship


class InterviewSession(BaseModel):
    __tablename__ = "InterviewSessions"
    id: Mapped[UUID] = mapped_column(primary_key=True)
    user_id: Mapped[UUID] = mapped_column(ForeignKey("Users.id"))
    user = relationship("User", backref="interview_sessions")
    teacher_id: Mapped[UUID] = mapped_column(ForeignKey("Teachers.id"))
    teacher = relationship("Teacher", backref="interview_sessions")
    start_at: Mapped[int]
    progress: Mapped[int] = mapped_column(
        ForeignKey("InterviewQuestions.order"))
    done: Mapped[bool]