from models import BaseModel
from sqlalchemy import String, ForeignKey
from typing import List, Optional
from sqlalchemy.orm import mapped_column, Mapped, relationship


class InterviewRecord(BaseModel):
    __tablebane__ = "InterviewRecords"
    id: Mapped[str] = mapped_column(primary_key=True)
    session_id: Mapped[str] = mapped_column(ForeignKey("InterviewSessions.id"))
    session = relationship("InterviewSession", backref="interview_records")
    total_earned_credits: Optional[Mapped[int]]
    planned_credits: Optional[Mapped[int]]
    gpa: Optional[Mapped[float]]
    attendance_rate: Optional[Mapped[float]]
    concern: Optional[Mapped[str]]
    prefer_in_person_interview: Optional[Mapped[bool]]
