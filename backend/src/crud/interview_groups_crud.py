from src.crud.base_crud import BaseCrud
from sqlalchemy.orm import Session
from src.models import InterviewQuestionGroup, InterviewQuestionGroupModel, InterviewQuestionGroupUpdate
from sqlalchemy.orm import selectinload


class InterviewGroupsCrud(BaseCrud[InterviewQuestionGroupModel, InterviewQuestionGroup, InterviewQuestionGroupUpdate]):
    def get_multi_with_questions(self, db_session: Session):
        return db_session.query(InterviewQuestionGroupModel).options(selectinload(InterviewQuestionGroupModel.questions)).all()