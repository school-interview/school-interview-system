from typing import Any
from src.models.websocket_controller_model import WebsocketController


async def speak_to_teacher(sid: str, data: Any):
    print("sid:{}, data:{}".format(sid, data), flush=True)


websocket_controllers = [
    WebsocketController("speak_to_teacher", speak_to_teacher)
]
