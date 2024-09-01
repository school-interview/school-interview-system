
from datetime import datetime
import logging
from time import time
from uuid import uuid4, UUID
from sqlalchemy.orm import Session
from src.models import InterviewSession
from typing import Optional
from src.usecases.websocket_connection.connection_managemet import get_connection_by_user_id
from socketio import AsyncServer


def start_interview(session: Session, user_id: UUID, teacher_id: UUID, delete_current_interview: bool = True):
    current_interview_query = session.query(
        InterviewSession).where(InterviewSession.user_id == user_id & InterviewSession.done == False)
    current_interview: Optional[InterviewSession] = session.execute(
        current_interview_query).first()
    if current_interview and delete_current_interview:
        finish_interview(session, current_interview)
        session.commit()
    elif current_interview:
        raise Exception(
            "The user {} are already in an interview session.".format(user_id))
    interview_session = InterviewSession(
        id=uuid4(),
        user_id=user_id,
        teacher_id=teacher_id,
        start_at=datetime.now(),
        progress=1,
        done=False
    )
    session.add(interview_session)
    session.commit()
    return interview_session


def finish_interview(session: Session, interview_id: UUID):
    interview_query = session.query(
        InterviewSession).where(InterviewSession.id == interview_id)
    interview_session: Optional[InterviewSession] = session.execute(
        interview_query).first()
    if not interview_session:
        raise Exception("Interview session not found.")
    interview_session.done = True
    session.commit()


async def speak_to_teacher(session: Session, sio: AsyncServer, user_id: UUID, teacher_id: UUID):
    connection = get_connection_by_user_id(session, user_id)[0]
    if not connection:
        raise Exception("User {} is not connected.".format(user_id))
    # ここでlang-chainを動かす。
    # ユーザーへの返答
    await sio.emit("message_from_teacher", {
        "message": "Hello, I'm teacher."}, to=connection.socket_id, skip_sid=True)
    logging.info("先生がメッセージを送りました")
