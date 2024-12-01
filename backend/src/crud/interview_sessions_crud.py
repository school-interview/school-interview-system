from uuid import UUID
from src.crud.base_crud import BaseCrud
from src.models import InterviewSessionModel, InterviewSession, InterviewSessionUpdate
from sqlalchemy.orm import Session, joinedload
from sqlalchemy.dialects import sqlite


class InterviewSessionsCrud(BaseCrud[InterviewSessionModel, InterviewSession, InterviewSessionUpdate]):
    def get_with_curernt_question(self, db_session: Session, id: UUID):
        return db_session.query(
            InterviewSessionModel
        ).options(
            joinedload(InterviewSessionModel.current_question, innerjoin=True)
        ).filter(
            InterviewSessionModel.id == id
        ).first()
