from typing import Dict, List, Optional
from uuid import UUID
import pytest
from pprint import pprint
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
    question_models = interview_questions_crud.get_multi(db_session)
    questions = list(map(lambda q: q.convert_to_pydantic(
        InterviewQuestion, set()), question_models))

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
        # mockの場合UUIDがstrになってしまうので変換。UUIDはstrを受け付けないのでエラーが出るがランタイム時はstrなので一旦ignore
        question_id = UUID(session.current_question_id)  # type: ignore
        session.current_question = InterviewQuestionModel(
            **questions_by_id[question_id].__dict__
        )
    return db_session, question_groups, questions, questions_by_group, interview_sessions, questions_by_id


def test_get_next_question(data_for_test):
    db_session, question_groups, questions, questions_by_group, interview_sessions, questions_by_id = data_for_test
    target_interivew_session = interview_sessions[0]
    group_2_id = question_groups[1].id
    group_2_question_1_id = questions_by_group[group_2_id][0].id
    group_3_id = question_groups[2].id
    group_3_question_1_id = questions_by_group[group_3_id][0].id
    group_4_id = question_groups[3].id
    group_4_question_1_id = questions_by_group[group_4_id][0].id
    group_4_question_2_id = questions_by_group[group_4_id][1].id
    group_5_id = question_groups[4].id
    group_5_question_1_id = questions_by_group[group_5_id][0].id
    group_6_id = question_groups[5].id
    group_6_question_1_id = questions_by_group[group_6_id][0].id

    def test_next_question(interview_session: InterviewSessionModel, next_question_id: Optional[UUID]):
        next_question = interview_session._get_next_question(
            question_groups, questions_by_group)
        if next_question_id is None:
            assert next_question is None
        else:
            if next_question is None:
                raise ValueError("The next question is not found.")
            assert (
                next_question.id
                ==
                next_question_id
            )
            interview_session.current_question_id = next_question_id
            interview_session.current_question = InterviewQuestionModel(
                **questions_by_id[next_question_id].__dict__
            )
        return next_question

    test_next_question(
        target_interivew_session, group_2_question_1_id)
    test_next_question(
        target_interivew_session, group_3_question_1_id)
    test_next_question(
        target_interivew_session, group_4_question_1_id)
    test_next_question(
        target_interivew_session, group_4_question_2_id)
    test_next_question(
        target_interivew_session, group_5_question_1_id)
    test_next_question(
        target_interivew_session, group_6_question_1_id)
    test_next_question(
        target_interivew_session, None)
