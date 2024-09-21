from typing import Optional
from uuid import UUID
from pydantic import BaseModel, Field
from sqlalchemy import ForeignKey
from src.models import InterviewSession, EntityBaseModel
from sqlalchemy.orm import mapped_column, Mapped, relationship


class InterviewAnalytics(BaseModel):
    id: UUID
    session_id: UUID
    session: Optional[InterviewSession] = Field(None)
    fail_to_move_to_next_grade: bool
    deviation_from_preferred_credit_level: float
    deviation_from_minimum_attendance_rate: float
    high_attendance_low_gpa_rate: float
    low_atendance_and_low_gpa_rate: float
    support_necessity_level: float


class InterviewAnalyticsModel(EntityBaseModel):
    __tablename__ = "InterviewAnalytics"
    id: Mapped[UUID] = mapped_column(primary_key=True)
    session_id: Mapped[UUID] = mapped_column(
        ForeignKey("InterviewSessions.id"))
    session = relationship("InterviewSessionModel", backref="analytics")
    fail_to_move_to_next_grade: Mapped[bool]
    deviation_from_preferred_credit_level: Mapped[float]
    deviation_from_minimum_attendance_rate: Mapped[float]
    high_attendance_low_gpa_rate: Mapped[float]
    low_atendance_and_low_gpa_rate: Mapped[float]
    support_necessity_level: Mapped[float]
