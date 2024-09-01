
from datetime import datetime
from time import time
from uuid import uuid4, UUID
from sqlalchemy.orm import Session
from src.models import InterviewSession


def start_interview(session: Session, user_id: UUID, teacher_id: UUID):
    current_interview_query = session.query(
        InterviewSession).where(InterviewSession.user_id == user_id)
    current_interview = session.execute(current_interview_query).first()
    if current_interview:
        raise Exception(
            "The user {} are already in an interview session.".format(user_id))
    interview_session = InterviewSession(
        id=uuid4(),
        user_id=user_id,
        teacher_id=teacher_id,
        start_at=datetime.now()
        pgoress=1,
        done=False
    )
    session.add(interview_session)
    session.commit()


def finish_interview(session: Session, interview_session: InterviewSession):


def speak_to_teacher(session: Session, ):
