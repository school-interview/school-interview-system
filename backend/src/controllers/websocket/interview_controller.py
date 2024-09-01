from typing import Any

from socketio import AsyncServer
from src.models.websocket_controller_model import WebsocketController
from sqlalchemy.orm import sessionmaker
import logging


async def speak_to_teacher(sid: str, data: Any):
    logging.info("sid:{}, data:{}".format(sid, data),)


interview_websocket_controllers = [
    WebsocketController("speak_to_teacher", speak_to_teacher)
]
