from typing import Any, Callable, Literal, Optional
from abc import ABCMeta, abstractmethod
from pydantic import BaseModel
from src.models import InterviewSession

HttpMethod = Literal["GET", "POST", "PUT", "DELETE"]


class RestApiController(metaclass=ABCMeta):
    method: HttpMethod
    path: str
    response_model: Optional[Any]

    @abstractmethod
    async def controller(self, *args: Any) -> Any:
        pass


class ErrorResponse(BaseModel):
    type: str
    title: str
    detail: Optional[str]


class InterviewSessionRequest(BaseModel):
    user_id: str
    teacher_id: str


class LoginRequest(BaseModel):
    student_id: str
    name: str
    department: str
    grade: int


class SpeakToTeacherRequest(BaseModel):
    message_from_teacher: str


class TeacherResponse(BaseModel):
    message_from_teacher: str


class StartInterviewResponse(BaseModel):
    interview_session: InterviewSession
    message_from_teacher: str