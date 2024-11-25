from src.crud.base_crud import BaseCrud
from src.models import InterviewQuestionModel, InterviewQuestion, InterviewQuestionUpdate
from sqlalchemy.orm import Session
from uuid import UUID


class InterviewQuestionsCrud(BaseCrud[InterviewQuestionModel, InterviewQuestion, InterviewQuestionUpdate]):
    def get_multi_by_group_id(self, db_session: Session, group_id: UUID):
        return (db_session.query(InterviewQuestionModel)
                .filter(InterviewQuestionModel.group_id == group_id)
                .order_by(InterviewQuestionModel.order)
                .all()
                )
