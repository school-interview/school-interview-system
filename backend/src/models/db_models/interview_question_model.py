from uuid import UUID
from src.models.db_models.base_model import EntityBaseModel
from typing import Optional
from sqlalchemy import String
from sqlalchemy.orm import mapped_column, Mapped
from src.models.app_pydantic_base_model import AppPydanticBaseModel


class InterviewQuestion(AppPydanticBaseModel):
    id: UUID
    question: str
    order: int
    prompt: str
    description: Optional[str]


class InterviewQuestionModel(EntityBaseModel):
    __tablename__ = "InterviewQuestions"
    id: Mapped[UUID] = mapped_column(primary_key=True)
    question: Mapped[str] = mapped_column(String(100))
    order: Mapped[int] = mapped_column(unique=True)
    prompt: Mapped[str] = mapped_column(String(200))
    description: Mapped[Optional[str]] = mapped_column(String(200))


class InterviewQuestionUpdate(AppPydanticBaseModel):
    question: str
    order: int
    prompt: str
    description: str
