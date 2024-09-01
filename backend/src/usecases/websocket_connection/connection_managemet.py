from typing import Tuple
import uuid
from sqlalchemy import Row
from sqlalchemy.orm import Session
from src.models import WebsocketConnection


def register_connection(session: Session, user_id: str, socket_id: str):
    current_connection = session.query(WebsocketConnection).filter(
        WebsocketConnection.user_id == user_id).first()
    if current_connection:
        current_connection.socket_id = socket_id
        session.commit()
        return current_connection
    else:
        new_connection = WebsocketConnection(
            id=uuid.uuid4(), user_id=user_id, socket_id=socket_id)
        session.add(new_connection)
        session.commit()
        return new_connection


def get_connection_by_user_id(session: Session, user_id: str) -> Tuple[WebsocketConnection]:
    connection_query = session.query(WebsocketConnection).where(
        WebsocketConnection.user_id == user_id)
    connection = session.execute(connection_query).first()
    if not connection:
        raise Exception("Connection not found.")
    return connection


def get_connection_by_socket_id(session: Session, socket_id: str) -> Tuple[WebsocketConnection]:
    connection_query = session.query(WebsocketConnection).where(
        WebsocketConnection.socket_id == socket_id)
    connection = session.execute(connection_query).first()
    if not connection:
        raise Exception("Connection not found.")
    return connection


def delete_connection(session: Session, socket_id: str):
    connection_query = session.query(WebsocketConnection).where(
        WebsocketConnection.socket_id == socket_id)
    connection = session.execute(connection_query).first()[0]
    if connection:
        session.delete(connection)
        session.commit()
        return connection
    else:
        raise Exception("Connection not found.")
