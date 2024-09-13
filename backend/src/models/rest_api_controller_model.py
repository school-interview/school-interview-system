from typing import Any, Callable, Literal, Optional
from abc import ABCMeta, abstractmethod

HttpMethod = Literal["GET", "POST", "PUT", "DELETE"]


class RestApiController(metaclass=ABCMeta):
    method: HttpMethod
    path: str
    response_model: Optional[Any]

    @abstractmethod
    async def controller(self, *args: Any) -> Any:
        pass
