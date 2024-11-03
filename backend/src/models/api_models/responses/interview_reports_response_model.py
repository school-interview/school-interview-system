from typing import List
from pydantic import BaseModel
from src.models.app_models.interview_report_model import InterviewReport


class InterviewReportResponse(BaseModel):
    reports: List[InterviewReport]
