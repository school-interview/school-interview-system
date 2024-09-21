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
    support_necessity_level: float


class InterviewAnalyticsModel(EntityBaseModel):
    __tablename__ = "InterviewAnalytics"
    id: Mapped[UUID] = mapped_column(primary_key=True)
    session_id: Mapped[UUID] = mapped_column(
        ForeignKey("InterviewSessions.id"))
    session = relationship("InterviewSessionModel", backref="analytics")
    support_necessity_level: Mapped[float]
