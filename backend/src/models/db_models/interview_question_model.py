from uuid import UUID
from src.models.db_models.base_model import EntityBaseModel
from typing import Any, Literal, Optional
from sqlalchemy import ForeignKey, String
from sqlalchemy.orm import mapped_column, Mapped
from src.models.app_pydantic_base_model import AppPydanticBaseModel


class InterviewQuestion(AppPydanticBaseModel):
    id: UUID
    question: str
    order: int
    group_id: UUID
    left_operand: Optional[str]
    left_operator: Optional[Literal['==', '>', '<', '>=', '<=', '!=']]
    right_operand: Optional[str]
    right_operator: Optional[Literal['==', '>', '<', '>=', '<=', '!=']]
    prompt: str
    description: Optional[str]
    extraction_data_type: Literal['int', 'float', 'str', 'bool']


class InterviewQuestionModel(EntityBaseModel):
    __tablename__ = "InterviewQuestions"
    id: Mapped[UUID] = mapped_column(primary_key=True)
    group_id: Mapped[UUID] = mapped_column(
        ForeignKey("InterviewQuestionGroup.id", ondelete="CASCADE"))
    question: Mapped[str] = mapped_column(String(100))
    order: Mapped[int] = mapped_column(unique=True)
    left_operand: Mapped[Optional[str]] = mapped_column(String(10))
    left_operator: Mapped[Optional[str]] = mapped_column(String(2))
    right_operand: Mapped[Optional[str]] = mapped_column(String(10))
    right_operator: Mapped[Optional[str]] = mapped_column(String(2))
    prompt: Mapped[str] = mapped_column(String(200))
    description: Mapped[Optional[str]] = mapped_column(String(200))
    extraction_data_type: Mapped[str] = mapped_column(String(5))


class InterviewQuestionUpdate(AppPydanticBaseModel):
    question: str
    order: int
    prompt: str
    description: str
