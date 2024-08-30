from typing import NamedTuple, Any, Callable, Literal
from pydantic import BaseModel

HttpMethod = Literal["GET", "POST", "PUT", "DELETE"]


class RestApiController(NamedTuple):
    method: HttpMethod
    path: str
    controller: Callable[..., Any]


class LoginRequest(BaseModel):
    student_id: str
    name: str
    department: str
    grade: int
