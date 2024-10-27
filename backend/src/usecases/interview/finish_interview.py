
from sqlalchemy.orm import Session
from src.models import InterviewSessionModel, InterviewRecordModel
from src.usecases.interview.analyze_interview import analyze_interview


def finish_interview(db_session: Session, interview_session: InterviewSessionModel, *, chat_history_store: dict = {}, interview_record: InterviewRecordModel):
    interview_session.done = True
    db_session.commit()
    store_key = interview_session.id.__str__()
    if interview_record:
        analyze_interview(db_session, interview_session, interview_record)
    if store_key in chat_history_store:
        del chat_history_store[store_key]
