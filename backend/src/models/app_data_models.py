from pydantic import BaseModel
from typing import Any, Callable, Literal, Optional
from src.models import InterviewSessionModel


class ExtractionResult(BaseModel):
    interview_session: InterviewSessionModel
    succeeded_to_extract: bool
    extracted_value: Optional[Any]
