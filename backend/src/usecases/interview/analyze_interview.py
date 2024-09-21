from src.models import InterviewRecordModel
from sqlalchemy.orm import Session
from src.models import InterviewAnalyticsModel, UserModel, InterviewSessionModel


def analyze_interview(db_session: Session, interview_session: InterviewSessionModel, interview_recrod: InterviewRecordModel):
    existing_interview_analytics_query = db_session.query(InterviewAnalyticsModel).where(
        InterviewAnalyticsModel.session_id == interview_recrod.session_id)
    query_result = db_session.execute(
        existing_interview_analytics_query).first()
    existing_interview_analytics = query_result[0] if query_result else None
    if existing_interview_analytics:
        # すでにInterviewAnalyticsが存在している場合はそのまま返す。
        return existing_interview_analytics
    user_query = db_session.query(UserModel).where(
        UserModel.id == interview_session.user_id)
    query_result = db_session.execute(user_query).first()
    user = query_result[0] if query_result else None
    interview_analytics = InterviewAnalyticsModel.create_from_interview_record(
        user, interview_recrod)
    db_session.add(interview_analytics)
    db_session.commit()
    return interview_analytics
