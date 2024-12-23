from uuid import UUID
from pydantic import BaseModel, ConfigDict
from typing import Any, Callable, Literal, Optional
from src.models.db_models.interview_session_model import InterviewSessionModel


class ExtractionResult(BaseModel):
    question_id_before_update: UUID
    interview_session: InterviewSessionModel
    succeeded_to_extract: bool
    extracted_value: Optional[Any]
    model_config = ConfigDict(arbitrary_types_allowed=True)
