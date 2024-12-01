from typing import Dict, List
from uuid import UUID
from src.crud.base_crud import BaseCrud
from src.models import InterviewRecordModel, InterviewRecord, InterviewRecordUpdate
from sqlalchemy.orm import Session


class InterviewRecordsCrud(BaseCrud[InterviewRecordModel, InterviewRecord, InterviewRecordUpdate]):

    def get_records_by_session_id(self, db_session: Session, session_id: UUID):
        return (
            db_session.query(InterviewRecordModel)
            .filter(InterviewRecordModel.session_id == session_id)
            .all()
        )
