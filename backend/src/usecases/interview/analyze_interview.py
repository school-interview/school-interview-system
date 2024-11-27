from src.models import InterviewRecordModel
from sqlalchemy.orm import Session
from src.models import InterviewAnalyticsModel, UserModel, InterviewSessionModel, NotStudentException, UserNotFoundException, InterviewQuestionGroupModel, interview_extracted_value_dict_factory
from src.crud import InterviewAnalyticsCrud, UsersCrud, InterviewQuestionGroupsCrud, InterviewRecordsCrud


def analyze_interview(db_session: Session, interview_session: InterviewSessionModel):
    """
    Args:
        db_session (Session): DB session
        interview_session (InterviewSessionModel): 
    """
    users_crud = UsersCrud(UserModel)
    analytics_crud = InterviewAnalyticsCrud(InterviewAnalyticsModel)
    groups_crud = InterviewQuestionGroupsCrud(InterviewQuestionGroupModel)
    records_crud = InterviewRecordsCrud(InterviewRecordModel)

    existing_interview_analytics = analytics_crud.get_by_session_id(
        db_session, interview_session.id)
    if existing_interview_analytics:
        # すでにInterviewAnalyticsが存在している場合はそのまま返す。
        return existing_interview_analytics
    user_model = users_crud.get_with_student(
        db_session, interview_session.user_id)
    if not user_model:
        raise UserNotFoundException("User not found.")
    if user_model.is_admin:
        raise NotStudentException("User is not a student.")
    if user_model.student is None:
        raise ValueError("Couldn't load student data.")
    groups = groups_crud.get_multi_with_questions_from_cache(db_session)
    records = records_crud.get_records_by_session_id(
        db_session, interview_session.id)
    interview_extracted_value_dict = interview_extracted_value_dict_factory(
        records, groups)
    interview_analytics = InterviewAnalyticsModel.interview_analytics_factory(
        interview_session, user_model.student,  interview_extracted_value_dict)
    analytics_crud.create(db_session, obj_in=interview_analytics)
    return interview_analytics
