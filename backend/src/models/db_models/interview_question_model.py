from uuid import UUID
from src.models.db_models.base_model import EntityBaseModel
from typing import Any, Literal, Optional
from sqlalchemy import ForeignKey, String
from sqlalchemy.orm import mapped_column, Mapped, relationship
from src.models.app_pydantic_base_model import AppPydanticBaseModel


class InterviewQuestion(AppPydanticBaseModel):
    id: UUID
    question: str
    order: int
    group_id: UUID
    condition_target_operand_data_type: Optional[Literal['int',
                                                         'float', 'str', 'bool']]
    condition_left_operand: Optional[str]
    condition_left_operator: Optional[Literal['==',
                                              '>', '<', '>=', '<=', '!=']]
    condition_right_operand: Optional[str]
    condition_right_operator: Optional[Literal['==',
                                               '>', '<', '>=', '<=', '!=']]
    prompt: str
    description: Optional[str]
    extraction_data_type: Literal['int', 'float', 'str', 'bool']


class InterviewQuestionModel(EntityBaseModel):
    __tablename__ = "InterviewQuestions"
    id: Mapped[UUID] = mapped_column(primary_key=True)
    group_id: Mapped[UUID] = mapped_column(
        ForeignKey("InterviewQuestionGroups.id", ondelete="CASCADE"))
    question: Mapped[str] = mapped_column(String(100))
    order: Mapped[int] = mapped_column(unique=True)
    condition_target_operand_data_type: Mapped[Optional[str]] = mapped_column(
        String(5))
    condition_left_operand: Mapped[Optional[str]] = mapped_column(String(10))
    condition_left_operator: Mapped[Optional[str]] = mapped_column(String(2))
    condition_right_operand: Mapped[Optional[str]] = mapped_column(String(10))
    condition_right_operator: Mapped[Optional[str]] = mapped_column(String(2))
    prompt: Mapped[str] = mapped_column(String(200))
    description: Mapped[Optional[str]] = mapped_column(String(200))
    extraction_data_type: Mapped[str] = mapped_column(String(5))


class InterviewQuestionUpdate(AppPydanticBaseModel):
    question: str
    order: int
    prompt: str
    description: str
