from uuid import UUID
from src.models import EntityBaseModel, User
from sqlalchemy import String, ForeignKey
from typing import Any, List, Optional
from sqlalchemy.orm import mapped_column, Mapped, relationship
from pydantic import BaseModel
from src.models.app_pydantic_base_model import AppPydanticBaseModel
from pydantic import Field


class InterviewRecord(AppPydanticBaseModel):
    id: UUID
    session_id: UUID
    session: Optional[Any] = Field(None)
    question_id: UUID
    question: Optional[Any] = Field(None)
    extracted_data: str


class InterviewRecordModel(EntityBaseModel):
    __tablename__ = "InterviewRecords"
    id: Mapped[UUID] = mapped_column(primary_key=True)
    session_id: Mapped[UUID] = mapped_column(
        ForeignKey("InterviewSessions.id", ondelete="CASCADE"))
    session: Mapped[Optional[Any]] = relationship("InterviewSessionModel",
                                                  backref="interview_records")
    question_id: Mapped[UUID] = mapped_column(
        ForeignKey("InterviewQuestions.id"))
    question: Mapped[Any] = relationship(
        "InterviewQuestionModel", back_populates="interview_records")
    extracted_data: Mapped[str] = mapped_column(String(100))


class InterviewRecordUpdate(AppPydanticBaseModel):
    extracted_data: str
