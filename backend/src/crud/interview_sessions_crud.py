from uuid import UUID
from src.crud.base_crud import BaseCrud
from src.models import InterviewSessionModel, InterviewSession, InterviewSessionUpdate
from sqlalchemy.orm import Session, joinedload


class InterviewSessionsCrud(BaseCrud[InterviewSessionModel, InterviewSession, InterviewSessionUpdate]):
    def get_with_curernt_question_by_user_id(self, db_session: Session, user_id: UUID):
        return db_session.query(
            InterviewSessionModel
        ).options(
            joinedload(InterviewSessionModel.current_question,
                       innerjoin=False)
        ).filter(
            InterviewSessionModel.user_id == user_id
        ).first()
