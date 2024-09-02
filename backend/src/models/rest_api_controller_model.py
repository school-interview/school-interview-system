from typing import Any, Callable, Literal
from abc import ABCMeta, abstractmethod

HttpMethod = Literal["GET", "POST", "PUT", "DELETE"]


class RestApiController(metaclass=ABCMeta):
    method: HttpMethod
    path: str

    @abstractmethod
    async def controller(self, *args: Any) -> Any:
        pass
