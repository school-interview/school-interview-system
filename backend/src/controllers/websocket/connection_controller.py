from fastapi import Depends
from src.usecases.websocket_connection.connection_managemet import delete_connection, register_connection
from src.models.db_models.user_model import User
from src.database import SessionMaker
from src.models.websocket_controller_model import WebsocketController
from typing import Dict, List
from src.usecases.auth.authenticate import authenticate
from sqlalchemy.orm import sessionmaker
import logging
from websocket_server import sio


async def connect(sid: str, environ, auth: Dict):
    logging.info("sid:{}  connected. user_id is {}".format(
        sid, auth['user_id']))
    session = SessionMaker()
    try:
        user = authenticate(session, auth['user_id'])
        register_connection(session, user.id, sid)
        socket_io_session = {
            'user': user
        }
        sio.save_session(sid, socket_io_session)
        logging.info("Authentication Succeed : user_id:{}".format(user.id))
    except Exception as e:
        logging.error("sid:{}  failed to connect".format(sid))
        raise ConnectionRefusedError('authentication failed')
    finally:
        session.close()


async def disconnect(sid: str):
    session = SessionMaker()
    try:
        delete_connection(session, sid)
    except Exception as e:
        logging.error("sid:{}  failed to disconnect".format(sid))
    finally:
        session.close()
    logging.info("sid:{}  disconnected".format(sid))


connection_websocket_controllers: List[WebsocketController] = [
    WebsocketController("connect", connect),
    WebsocketController("disconnect", disconnect)
]
