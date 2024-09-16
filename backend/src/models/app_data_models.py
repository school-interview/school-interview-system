from pydantic import BaseModel
from typing import Any, Callable, Literal
from src.models import InterviewSession


class InterviewSessionRequest(BaseModel):
    user_id: str
    teacher_id: str


class LoginRequest(BaseModel):
    student_id: str
    name: str
    department: str
    grade: int


class SpeakToTeacherRequest(BaseModel):
    message: str


class TeacherResponse(BaseModel):
    message: str


class ExtractionResult(BaseModel):
    interview_session: InterviewSession
    succeeded_to_extract: bool
