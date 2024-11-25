from typing import List
from src.crud.base_crud import BaseCrud
from sqlalchemy.orm import Session
from src.models import InterviewQuestionGroup, InterviewQuestionGroupModel, InterviewQuestionGroupUpdate, InterviewQuestion
from sqlalchemy.orm import selectinload


class InterviewQuestionGroupsCrud(BaseCrud[InterviewQuestionGroupModel, InterviewQuestionGroup, InterviewQuestionGroupUpdate]):

    _interview_groups_cache: List[InterviewQuestionGroup] = []

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
                    )  # type: ignore
                )
        return self._interview_groups_cache
