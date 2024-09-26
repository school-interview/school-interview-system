from typing import Any, Callable, List, Literal, Optional
from abc import ABCMeta, abstractmethod
from pydantic import BaseModel
from src.models import InterviewSession, Teacher

HttpMethod = Literal["GET", "POST", "PUT", "DELETE"]


class RestApiController(metaclass=ABCMeta):
    method: HttpMethod
    path: str
    response_model: Optional[Any]

    @abstractmethod
    async def controller(self, *args: Any) -> Any:
        pass


class ErrorResponse(Exception):
    def __init__(self, status_code: int, type: str, title: str, detail: Optional[str]):
        self.status_code = status_code
        self.type = type
        self.title = title
        self.detail = detail


class InterviewSessionRequest(BaseModel):
    user_id: str
    teacher_id: str


class LoginRequest(BaseModel):
    student_id: str
    name: str
    department: str
    semester: int


class SpeakToTeacherRequest(BaseModel):
    message_from_student: str


class TeacherResponse(BaseModel):
    interview_session: InterviewSession
    message_from_teacher: str


class StartInterviewResponse(BaseModel):
    interview_session: InterviewSession
    message_from_teacher: str


class TeachersListResponse(BaseModel):
    teachers: List[Teacher]
    count: int
