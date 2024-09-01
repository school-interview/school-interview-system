from fastapi import Depends
from src.models.db_models.user_model import User
from src.database import SessionMaker
from src.models.websocket_controller_model import WebsocketController
from typing import Dict, List
from src.usecases.websocket_connection.connection_managemet import register_connection
from src.usecases.auth.authenticate import authenticate
from sqlalchemy.orm import sessionmaker
import logging


async def connect(sid: str, environ, auth: Dict):
    logging.info("sid:{}  connected. user_id is {}".format(
        sid, auth['user_id']))
    session = SessionMaker()
    try:
        user = authenticate(session, auth['user_id'])
        logging.info("認証成功: user_id:{}".format(user.id))
    except Exception as e:
        raise ConnectionRefusedError('authentication failed')
    finally:
        session.close()


async def disconnect(sid: str):
    logging.info("sid:{}  disconnected".format(sid))


connection_websocket_controllers: List[WebsocketController] = [
    WebsocketController("connect", connect),
    WebsocketController("disconnect", disconnect)
]
