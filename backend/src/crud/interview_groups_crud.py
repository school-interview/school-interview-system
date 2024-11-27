from typing import Dict, List
from uuid import UUID
from src.crud.base_crud import BaseCrud
from sqlalchemy.orm import Session
from src.models import InterviewQuestionGroup, InterviewQuestionGroupModel, InterviewQuestionGroupUpdate, InterviewQuestion
from sqlalchemy.orm import selectinload


class InterviewQuestionGroupsCrud(BaseCrud[InterviewQuestionGroupModel, InterviewQuestionGroup, InterviewQuestionGroupUpdate]):

    _interview_groups_cache: List[InterviewQuestionGroup] = []
    _interivew_questions_by_group_cache: Dict[UUID,
                                              List[InterviewQuestion]] = {}

    def get_multi_with_questions(self, db_session: Session):
        return (db_session.query(InterviewQuestionGroupModel)
                .order_by(InterviewQuestionGroupModel.order)
                .options(selectinload(InterviewQuestionGroupModel.questions))
                .all()
                )

    def get_multi_with_questions_from_cache(self, db_session: Session):
        if len(self._interview_groups_cache) == 0:
            model_class_mapping = {
                "InterviewQuestionModel": InterviewQuestion,
            }
            groups = self.get_multi_with_questions(db_session)
            for g in groups:
                self._interview_groups_cache.append(
                    g.convert_to_pydantic(
                        InterviewQuestionGroup,
                        obj_history=set(),
                        model_class_mapping=model_class_mapping
                    )
                )
        return self._interview_groups_cache

    def get_questions_by_group(self, db_session: Session):
        if len(self._interivew_questions_by_group_cache.keys()) == 0:
            groups = self.get_multi_with_questions_from_cache(db_session)
            for group in groups:
                if group.questions is None:
                    raise ValueError(
                        "Coundn't load questions in InterviewQuestionGroup.")
                self._interivew_questions_by_group_cache[group.id] = group.questions
        return self._interivew_questions_by_group_cache
