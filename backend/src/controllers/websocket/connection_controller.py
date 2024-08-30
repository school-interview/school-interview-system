from src.models.websocket_controller_model import WebsocketController
from typing import List
from src.usecases.websocket_connection.connection_managemet import register_connection


async def connect(sid: str):
    print("sid:{}  connected".format(sid), flush=True)
    # register_connection(sid,)


async def disconnect(sid: str):
    print("sid:{}  disconnected".format(sid), flush=True)


connection_websocket_controllers: List[WebsocketController] = [
    WebsocketController("connect", connect),
    WebsocketController("disconnect", disconnect)
]
