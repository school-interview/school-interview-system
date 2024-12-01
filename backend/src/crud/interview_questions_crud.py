from typing import Dict, List
from src.crud.base_crud import BaseCrud
from src.models import InterviewQuestionModel, InterviewQuestion, InterviewQuestionUpdate
from sqlalchemy.orm import Session
from uuid import UUID


class InterviewQuestionsCrud(BaseCrud[InterviewQuestionModel, InterviewQuestion, InterviewQuestionUpdate]):
    _interview_questions_dict_cache: Dict[UUID, InterviewQuestion] = {}

    def get_multi_by_group_id(self, db_session: Session, group_id: UUID):
        return (db_session.query(InterviewQuestionModel)
                .filter(InterviewQuestionModel.group_id == group_id)
                .order_by(InterviewQuestionModel.order)
                .all()
                )

    def get_multi_in_dict(self, db_session: Session):
        if len(self._interview_questions_dict_cache.keys()) == 0:
            questions = self.get_multi(db_session)
            for q in questions:
                self._interview_questions_dict_cache[q.id] = q.convert_to_pydantic(
                    InterviewQuestion, obj_history=set())
        return self._interview_questions_dict_cache
