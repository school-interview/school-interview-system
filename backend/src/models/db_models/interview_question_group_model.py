from uuid import UUID
from typing import Any, List, Optional
from sqlalchemy import String
from src.models.db_models.base_model import EntityBaseModel
from src.models.app_pydantic_base_model import AppPydanticBaseModel
from src.models.db_models.interview_question_model import InterviewQuestion, InterviewQuestionModel
from sqlalchemy.orm import mapped_column, Mapped, relationship


class InterviewQuestionGroup(AppPydanticBaseModel):
    id: UUID
    group_name: str
    order: int
    questions: List[InterviewQuestion]


class InterviewQuestionGroupModel(EntityBaseModel):
    __tablename__ = "InterviewQuestionGroups"
    id: Mapped[UUID] = mapped_column(primary_key=True)
    group_name: Mapped[str] = mapped_column(String(100))
    questions: Mapped[List[InterviewQuestionModel]] = relationship()