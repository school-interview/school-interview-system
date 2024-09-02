from typing import Any, Callable, Literal
from abc import ABCMeta, abstractmethod
from pydantic import BaseModel

HttpMethod = Literal["GET", "POST", "PUT", "DELETE"]


class RestApiController(metaclass=ABCMeta):
    method: HttpMethod
    path: str

    @abstractmethod
    async def controller(self, *args: Any) -> Any:
        pass


class LoginRequest(BaseModel):
    student_id: str
    name: str
    department: str
    grade: int
