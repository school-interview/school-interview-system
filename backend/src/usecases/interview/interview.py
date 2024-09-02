
from datetime import datetime
import logging
from time import time
from uuid import uuid4, UUID
from sqlalchemy.orm import Session
from src.models import InterviewSession, TeacherResponse
from typing import Optional
from src.usecases.websocket_connection.connection_managemet import get_connection_by_user_id
from socketio import AsyncServer


def start_interview(session: Session, user_id: UUID, teacher_id: UUID, delete_current_interview: bool = True):
    current_interview_query = session.query(
        InterviewSession).where(InterviewSession.user_id == user_id and InterviewSession.done == False)
    current_interview: Optional[InterviewSession] = session.execute(
        current_interview_query).first()[0]
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


def finish_interview(session: Session, interview_session: InterviewSession):
    interview_session.done = True
    session.commit()


def speak_to_teacher(session: Session, interview_session: InterviewSession, message_from_user: str):
    if interview_session.done:
        raise Exception("The interview session is already done.")
    response = TeacherResponse(message="Hello I am teacher")
    return response
