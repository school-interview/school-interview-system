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
    questions = interview_questions_crud.get_multi(db_session)

    questions_by_group: Dict[UUID, List[InterviewQuestionModel]] = {}
    for group in question_groups:
        for question in questions:
            if question.group_id == group.id:
                if group.id not in questions_by_group:
                    questions_by_group[group.id] = []
                questions_by_group[group.id].append(question)
        questions_by_group[group.id].sort(key=lambda x: x.order)

    questions_by_id: Dict[UUID, InterviewQuestionModel] = {}
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
        session.current_question = questions_by_id[question_id]
    return db_session, question_groups, questions, questions_by_group, interview_sessions, questions_by_id


def test_get_next_question(data_for_test):
    """
          次の質問の判定ロジックのテスト
    """
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
            interview_session.current_question = questions_by_id[next_question_id]
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


def test_move_on_next_question(data_for_test):
    """
          次の質問に進めるかのテスト
    """
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

    def test_next_question(interview_session: InterviewSessionModel, next_question_id: Optional[UUID], previous_extracted_value: str):
        next_question = (
            interview_session._move_on_next_question(
                db_session,
                question_groups,
                questions_by_group,
                previous_extracted_value
            ))
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
            interview_session.current_question = questions_by_id[next_question_id]
        return next_question
    # 現状の単位数→今学期取得予定単位数
    test_next_question(
        target_interivew_session, group_2_question_1_id, "30")
    # 今学期取得予定単位数→累計GPA
    test_next_question(
        target_interivew_session, group_3_question_1_id, "20")
    # 累計GPA→出席率
    test_next_question(
        target_interivew_session, group_4_question_1_id, "3.0")
    # 出席率→なぜ出席率低いのか
    test_next_question(
        target_interivew_session, group_4_question_2_id, "79")
    # 出席率OKパターンのテストのために戻す
    target_interivew_session.current_question_id = group_4_question_1_id
    # 出席率→困っていることはないか
    test_next_question(
        target_interivew_session, group_5_question_1_id, "80")
    # 困っていることはないか→教員との面談希望
    test_next_question(
        target_interivew_session, group_6_question_1_id, "None")
    # 教員との面談希望→None
    test_next_question(
        target_interivew_session, None, "教員との面談を希望します")
