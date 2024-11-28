
from sqlalchemy.orm import Session
from src.models import InterviewSessionModel, InterviewRecordModel
from src.usecases.interview.analyze_interview import analyze_interview


def finish_interview(db_session: Session, interview_session: InterviewSessionModel, *, chat_history_store: dict = {}):
    """
        Args:
            db_session (Session): DB session
            interview_session (InterviewSessionModel): 面談セッション
            chat_history_store (dict): 会話履歴の保存先
            interview_record (InterviewRecordModel): 面談の記録。Noneの場合はanalyzeしない。(analyze結果はテーブルに保存される）
    """
    interview_session.done = True
    db_session.commit()
    store_key = interview_session.id.__str__()
    analyze_interview(db_session, interview_session)
    if store_key in chat_history_store:
        del chat_history_store[store_key]
