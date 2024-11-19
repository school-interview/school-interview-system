from uuid import UUID
from src.models.db_models.base_model import EntityBaseModel
from typing import Any, Optional
from sqlalchemy import ForeignKey, String
from sqlalchemy.orm import mapped_column, Mapped
from src.models.app_pydantic_base_model import AppPydanticBaseModel


class InterviewQuestion(AppPydanticBaseModel):
    id: UUID
    question: str
    order: int
    group_id: UUID
    condition_value: Optional[str]
    condition_operator: Optional[str]
    prompt: str
    description: Optional[str]


class InterviewQuestionModel(EntityBaseModel):
    __tablename__ = "InterviewQuestions"
    id: Mapped[UUID] = mapped_column(primary_key=True)
    group_id: Mapped[UUID] = mapped_column(
        ForeignKey("InterviewQuestionGroup.id", ondelete="CASCADE"))
    question: Mapped[str] = mapped_column(String(100))
    order: Mapped[int] = mapped_column(unique=True)
    condition_value: Mapped[Optional[str]] = mapped_column(String(20))
    condition_operator: Mapped[Optional[str]] = mapped_column(String(2))
    prompt: Mapped[str] = mapped_column(String(200))
    description: Mapped[Optional[str]] = mapped_column(String(200))


class InterviewQuestionUpdate(AppPydanticBaseModel):
    question: str
    order: int
    prompt: str
    description: str
