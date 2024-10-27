from src.models import InterviewRecordModel
from sqlalchemy.orm import Session
from src.models import InterviewAnalyticsModel, UserModel, StudentModel, AdminModel, InterviewSessionModel, NotStudentException, UserNotFoundException
from src.crud import InterviewAnalyticsCrud, UsersCrud, StudentsCrud


def analyze_interview(db_session: Session, interview_session: InterviewSessionModel, interview_recrod: InterviewRecordModel):
    """
    Args:
        db_session (Session): DB session
        interview_session (InterviewSessionModel): 
        interview_recrod (InterviewRecordModel):
    """
    analytics_crud = InterviewAnalyticsCrud(InterviewAnalyticsModel)
    existing_interview_analytics = analytics_crud.get_by_session_id(
        interview_session.id)
    if existing_interview_analytics:
        # すでにInterviewAnalyticsが存在している場合はそのまま返す。
        return existing_interview_analytics
    users_crud = UsersCrud(UserModel)
    user_model = users_crud.get_with_student(
        db_session, interview_session.user_id)
    if not user_model:
        raise UserNotFoundException("User not found.")
    if user_model.is_admin:
        raise NotStudentException("User is not a student.")
    interview_analytics = InterviewAnalyticsModel.create_from_interview_record(
        user_model.student, interview_recrod)
    analytics_crud.create(db_session, interview_analytics)
    return interview_analytics
