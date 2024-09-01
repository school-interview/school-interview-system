from typing import Any
from src.usecases.interview.interview import speak_to_teacher
from websocket_server import sio
from socketio import AsyncServer
from src.database import SessionMaker
from src.models import WebsocketController, WebsocketConnection
from sqlalchemy.orm import sessionmaker
from sqlalchemy.orm import Session
import logging
from src.usecases.websocket_connection.connection_managemet import get_connection_by_socket_id


async def speak_to_teacher_controller(sid: str, data: Any):
    session: Session = SessionMaker()
    # connection = get_connection_by_socket_id(session, sid)[0]
    query = session.query(WebsocketConnection)
    connection = session.execute(query).first()[0]

    return await speak_to_teacher(session, sio, connection.user_id, "1")


interview_websocket_controllers = [
    WebsocketController("speak_to_teacher", speak_to_teacher_controller)
]
