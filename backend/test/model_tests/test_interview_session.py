import pytest
from test.model_tests.seeding_fixtures import db_session


# @pytest.fixture
# def groups_and_questions(db_session):
#     question_groups = interview_question_groups_crud.get_multi_with_questions(
#         db_session)
#     questions = interview_questions_crud.get_multi(db_session)
#     questions_by_group: Dict[UUID, List[InterviewQuestionModel]] = {}
#     for group in question_groups:
#         for question in questions:
#             if question.group_id == group.id:
#                 if group.id not in questions_by_group:
#                     questions_by_group[group.id] = []
#                 questions_by_group[group.id].append(question)
#         questions_by_group[group.id].sort(key=lambda x: x.order)
#     return question_groups, questions, questions_by_group
