from typing import Any, NamedTuple, Callable


class WebsocketController(NamedTuple):
    event_name: str
    controller: Callable[..., Any]
