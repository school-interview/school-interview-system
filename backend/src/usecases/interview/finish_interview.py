
from sqlalchemy.orm import Session
from src.models import InterviewSessionModel


def finish_interview(session: Session, interview_session: InterviewSessionModel, chat_history_store: dict = {}):
    interview_session.done = True
    session.commit()
    store_key = interview_session.id.__str__()
    if store_key in chat_history_store:
        del chat_history_store[store_key]
