from uuid import UUID
from src.models import EntityBaseModel, User
from sqlalchemy import String, ForeignKey
from typing import List, Optional
from sqlalchemy.orm import mapped_column, Mapped, relationship
from pydantic import BaseModel
from src.models.app_pydantic_base_model import AppPydanticBaseModel


class InterviewRecord(AppPydanticBaseModel):
    id: UUID
    session_id: UUID
    total_earned_credits: Optional[int]
    planned_credits: Optional[int]
    gpa: Optional[float]
    attendance_rate: Optional[float]
    concern: Optional[str]
    prefer_in_person_interview: Optional[bool]


class InterviewRecordModel(EntityBaseModel):
    __tablename__ = "InterviewRecords"
    id: Mapped[UUID] = mapped_column(primary_key=True)
    session_id: Mapped[UUID] = mapped_column(
        ForeignKey("InterviewSessions.id"))
    session = relationship("InterviewSessionModel",
                           backref="interview_records")
    total_earned_credits: Mapped[Optional[int]]
    planned_credits: Mapped[Optional[int]]
    gpa: Mapped[Optional[float]]
    attendance_rate: Mapped[Optional[float]]
    concern: Mapped[Optional[str]]
    prefer_in_person_interview: Mapped[Optional[bool]]


class InterviewRecordUpdate(AppPydanticBaseModel):
    total_earned_credits: int
    planned_credits: int
    gpa: float
    attendance_rate: float
    concern: str
    prefer_in_person_interview: bool
