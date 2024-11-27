from typing import Dict, List
from uuid import UUID
import pytest
from test.model_tests.seeding_fixtures import db_session
from src.crud import UsersCrud, StudentsCrud, InterviewSessionsCrud, TeachersCrud, InterviewQuestionGroupsCrud, InterviewQuestionsCrud
from src.models import UserModel, StudentModel, InterviewSessionModel, TeacherModel, InterviewQuestion, InterviewQuestionGroup, InterviewQuestionGroupModel, InterviewQuestionModel
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
    question_groups = list(map(lambda g: g.convert_to_pydantic(
        InterviewQuestionGroup, set()), question_groups)
    )
    questions = interview_questions_crud.get_multi(db_session)
    questions = list(map(lambda q: q.convert_to_pydantic(
        InterviewQuestion, set()), questions))

    questions_by_group: Dict[UUID, List[InterviewQuestion]] = {}
    for group in question_groups:
        for question in questions:
            if question.group_id == group.id:
                if group.id not in questions_by_group:
                    questions_by_group[group.id] = []
                questions_by_group[group.id].append(question)
        questions_by_group[group.id].sort(key=lambda x: x.order)

    questions_by_id: Dict[UUID, InterviewQuestion] = {}
    for question in questions:
        questions_by_id[question.id] = question

    interview_sessions = interview_sessions_crud.get_multi(db_session)

    interview_sessions_dict: Dict[UUID, InterviewSessionModel] = {}
    for session in interview_sessions:
        interview_sessions_dict[session.id] = session

        # mockでjoinedloadがうまくいかないので手動で結合
    for session in interview_sessions:
        session.current_question = InterviewQuestionModel(
            **questions_by_id[session.current_question_id].__dict__
        )

    return question_groups, questions, questions_by_group, interview_sessions
