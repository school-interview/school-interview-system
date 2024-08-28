from models import BaseModel
from sqlalchemy import String, ForeignKey
from typing import List
from sqlalchemy.orm import mapped_column, Mapped, relationship


class InterviewSession(BaseModel):
    __tablename__ = "InterviewSessions"
    id: Mapped[str] = mapped_column(primary_key=True)
    user_id: Mapped[str] = mapped_column(ForeignKey("Users.id"))
    user = relationship("User", backref="interview_sessions")
    teacher_id: Mapped[str] = mapped_column(ForeignKey("Teachers.id"))
    teacher = relationship("Teacher", backref="interview_sessions")
    start_at: Mapped[int]
    progress = mapped_column(ForeignKey("InterviewSessions.order"))
    done: Mapped[bool]
