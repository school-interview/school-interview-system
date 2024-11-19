from uuid import UUID
from typing import Any, List, Optional
from src.models.db_models.base_model import EntityBaseModel
from src.models.app_pydantic_base_model import AppPydanticBaseModel
from src.models.db_models.interview_question_model import InterviewQuestion, InterviewQuestionModel


class InterviewQuestionGroup(AppPydanticBaseModel):
    id: UUID
    group_name: str
    order: int
    questions: List[InterviewQuestion]
