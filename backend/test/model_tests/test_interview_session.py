from typing import Dict, List
from uuid import UUID
import pytest
from test.model_tests.seeding_fixtures import db_session
from src.crud import UsersCrud, StudentsCrud, InterviewSessionsCrud, TeachersCrud, InterviewQuestionGroupsCrud, InterviewQuestionsCrud
from src.models import UserModel, StudentModel, InterviewSessionModel, TeacherModel, InterviewQuestionGroupModel, InterviewQuestionModel
users_crud = UsersCrud(UserModel)
students_crud = StudentsCrud(StudentModel)
interview_sessions_crud = InterviewSessionsCrud(InterviewSessionModel)
teachers_crud = TeachersCrud(TeacherModel)
interview_question_groups_crud = InterviewQuestionGroupsCrud(
    InterviewQuestionGroupModel)
interview_questions_crud = InterviewQuestionsCrud(InterviewQuestionModel)


@pytest.fixture
def data_for_test(db_session):
    question_groups = interview_question_groups_crud.get_multi_with_questions(
        db_session)
    questions = interview_questions_crud.get_multi(db_session)
    questions_by_group: Dict[UUID, List[InterviewQuestionModel]] = {}
    for group in question_groups:
        for question in questions:
            if question.group_id == group.id:
                if group.id not in questions_by_group:
                    questions_by_group[group.id] = []
                questions_by_group[group.id].append(question)
        questions_by_group[group.id].sort(key=lambda x: x.order)
    return question_groups, questions, questions_by_group
