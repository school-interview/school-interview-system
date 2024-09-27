from pydantic import BaseModel
from src.models import InterviewSession


class StartInterviewResponse(BaseModel):
    interview_session: InterviewSession
    message_from_teacher: str
