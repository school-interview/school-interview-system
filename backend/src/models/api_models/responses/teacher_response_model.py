from pydantic import BaseModel
from src.models import InterviewSession


class TeacherResponse(BaseModel):
    interview_session: InterviewSession
    message_from_teacher: str
