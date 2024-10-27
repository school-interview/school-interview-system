from sqlalchemy import Tuple
from src.crud.base_crud import BaseCrud
from src.models import InterviewAnalyticsModel, InterviewAnalytics, InterviewAnalyticsUpdate, InterviewSessionModel, UserModel
from sqlalchemy.orm import Session


class InterviewAnalyticsCrud(BaseCrud[InterviewAnalyticsModel, InterviewAnalytics, InterviewAnalyticsUpdate]):

    def get_multi_with_user_and_session(self, db_session: Session):
        return db_session.query(InterviewAnalyticsModel, InterviewSessionModel, UserModel
                                ).join(
            InterviewSessionModel, InterviewAnalyticsModel.session_id == InterviewSessionModel.id
        ).join(
            UserModel, InterviewSessionModel.user_id == UserModel.id
        ).all()

    def get_by_session_id(self, db_session: Session, session_id: str):
        return db_session.query(InterviewAnalyticsModel).filter(InterviewAnalyticsModel.session_id == session_id).first()
