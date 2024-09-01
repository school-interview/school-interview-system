import uuid
from sqlalchemy import Connection
from sqlalchemy.orm import Session


def register_connection(session: Session, user_id: str, websocket_id: str):
    existing_connection = session.query(Connection).filter(
        Connection.user_id == user_id).first()
    if existing_connection:
        existing_connection.socket_id = websocket_id
        session.commit()
        return existing_connection
    else:
        new_connection = Connection(
            id=uuid.uuid4(), user_id=user_id, socket_id=websocket_id)
        session.add(new_connection)
        session.commit()
        return new_connection
