from datetime import datetime
from typing import Dict, List, Optional
from uuid import uuid4
from src.models import InterviewQuestionModel, InterviewQuestionGroupModel, TeacherModel, InterviewAnalyticsModel, UserModel, InterviewRecordModel, InterviewSessionModel, StudentModel
from test.model_tests.seeding_fixtures import db_session, db_session_module_scoped
from src.crud import UsersCrud, StudentsCrud, InterviewSessionsCrud, InterviewRecordsCrud, TeachersCrud, InterviewQuestionGroupsCrud, InterviewQuestionsCrud
import pytest
from uuid import UUID

users_crud = UsersCrud(UserModel)
students_crud = StudentsCrud(StudentModel)
interview_sessions_crud = InterviewSessionsCrud(InterviewSessionModel)
teachers_crud = TeachersCrud(TeacherModel)
interview_question_groups_crud = InterviewQuestionGroupsCrud(
    InterviewQuestionGroupModel)
interview_questions_crud = InterviewQuestionsCrud(InterviewQuestionModel)
interview_records_crud = InterviewRecordsCrud(InterviewRecordModel)


@pytest.fixture
def data_for_test(db_session_module_scoped):
    db_session = db_session_module_scoped
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

    def get_question_by_order_expression(order_expression: str) -> Optional[InterviewQuestionModel]:
        """
          order_expressionに基づいて質問を取得する。
        Args:
          order_expression (str): `group_order-question_order`の形式の文字列。例: `1-1`
        Returns:
          Optional[InterviewQuestionModel]: 該当する質問が存在すればその質問、存在しなければNone
        Raises:
        """
        group_order, question_order = map(int, order_expression.split("-"))
        for g in question_groups:
            if g.order == group_order:
                for q in questions_by_group[g.id]:
                    if q.order == question_order:
                        return q
        return None

    return db_session, question_groups, questions, questions_by_group, interview_sessions, questions_by_id, get_question_by_order_expression


@pytest.fixture
def student_1(data_for_test):
    db_session, question_groups, questions, questions_by_group, interview_sessions, questions_by_id, get_question_by_order_expression = data_for_test

    # １年後期に行われた面談で、順調な学生
    user_model = UserModel(
        id=uuid4(),
        name="藤崎暖",
        email="a1119331@kanazawa-it.ac.jp",
        is_admin=False
    )
    users_crud.create(db_session=db_session, obj_in=user_model)
    student_model = StudentModel(
        id=uuid4(),
        user_id=user_model.id,
        student_id="1119059",
        department="情報工学部",
        semester=2
    )
    students_crud.create(db_session=db_session, obj_in=student_model)
    interview_session = InterviewSessionModel(
        id=uuid4(),
        user_id=user_model.id,
        teacher_id=uuid4(),
        current_question_id=questions[-1].id,
        start_at=datetime.now(),
        progress=6,
        done=True
    )
    interview_sessions_crud.create(db_session=db_session,
                                   obj_in=interview_session)

    interview_records: List[InterviewRecordModel] = [
        InterviewRecordModel(
            id=uuid4(),
            session_id=interview_session.id,
            question_id=get_question_by_order_expression("1-1").id,
            extracted_data="35",
        ),
        InterviewRecordModel(
            id=uuid4(),
            session_id=interview_session.id,
            question_id=get_question_by_order_expression("2-1").id,
            extracted_data="20",
        ),
        InterviewRecordModel(
            id=uuid4(),
            session_id=interview_session.id,
            question_id=get_question_by_order_expression("3-1").id,
            extracted_data="3.3",
        ),
        InterviewRecordModel(
            id=uuid4(),
            session_id=interview_session.id,
            question_id=get_question_by_order_expression("4-1").id,
            extracted_data="80",
        ),
        InterviewRecordModel(
            id=uuid4(),
            session_id=interview_session.id,
            question_id=get_question_by_order_expression("5-1").id,
            extracted_data="None",
        ),
        InterviewRecordModel(
            id=uuid4(),
            session_id=interview_session.id,
            question_id=get_question_by_order_expression("6-1").id,
            extracted_data="False",
        ),
    ]

    for r in interview_records:
        interview_records_crud.create(db_session=db_session, obj_in=r)

    return user_model, student_model, interview_session, interview_records


def test_student1(student_1):
    user_model, student_model, interview_session, interview_record = student_1
    analytics = InterviewAnalyticsModel.interview_analytics_factory(
        student, record)
    assert analytics.fail_to_move_to_next_grade == False
    assert analytics.deviation_from_preferred_credit_level == 0
    assert analytics.deviation_from_minimum_attendance_rate == 0
    assert analytics.high_attendance_low_gpa_rate == 0
    assert analytics.low_atendance_and_low_gpa_rate == 0
    assert analytics.support_necessity_level == 0


def create_student_2():
    # 2年前期で行われた面談で、推奨獲得単位数を達成できていない学生。
    user_model = UserModel(
        id=uuid4(),
        name="藤崎暖",
        email="a1119331@kanazawa-it.ac.jp",
        is_admin=False
    )
    student_model = StudentModel(
        id=uuid4(),
        user_id=user_model.id,
        student_id="1119059",
        department="情報工学部",
        semester=3
    )
    interview_session = InterviewSessionModel(
        id=uuid4(),
        user_id=user_model.id,
        teacher_id=uuid4(),
        start_at=datetime.now(),
        progress=6,
        done=True
    )
    interview_record = InterviewRecordModel(
        id=uuid4(),
        session_id=interview_session.id,
        total_earned_credits=35,
        planned_credits=20,
        gpa=3.3,
        attendance_rate=80,
        concern=None,
        prefer_in_person_interview=False
    )
    return user_model, student_model, interview_session, interview_record


def test_student2():
    _, setudent, _, record = create_student_2()
    analytics = InterviewAnalyticsModel.create_from_interview_record(
        setudent, record)
    assert analytics.fail_to_move_to_next_grade == False
    assert analytics.deviation_from_minimum_attendance_rate == 0
    assert round(analytics.deviation_from_preferred_credit_level, 2) == 0.45
    assert analytics.high_attendance_low_gpa_rate == 0
    assert analytics.low_atendance_and_low_gpa_rate == 0
    assert round(analytics.support_necessity_level, 2) == 12.5


def create_student_3():
    # 2年後期で行われた面談で、単位数的にはギリ進級できる学生
    user_model = UserModel(
        id=uuid4(),
        name="藤崎暖",
        email="a1119331@kanazawa-it.ac.jp",
        is_admin=False
    )
    student_model = StudentModel(
        id=uuid4(),
        user_id=user_model.id,
        student_id="1119059",
        department="情報工学部",
        semester=4
    )
    interview_session = InterviewSessionModel(
        id=uuid4(),
        user_id=user_model.id,
        teacher_id=uuid4(),
        start_at=datetime.now(),
        progress=6,
        done=True
    )
    interview_record = InterviewRecordModel(
        id=uuid4(),
        session_id=interview_session.id,
        total_earned_credits=46,
        planned_credits=18,
        gpa=1.53,
        attendance_rate=87,
        concern=None,
        prefer_in_person_interview=False
    )
    return user_model, student_model, interview_session, interview_record


def test_student_3():
    _, student, _, record = create_student_3()
    analytics = InterviewAnalyticsModel.create_from_interview_record(
        student, record)
    assert analytics.fail_to_move_to_next_grade == False
    assert analytics.deviation_from_minimum_attendance_rate == 0
    assert round(analytics.deviation_from_preferred_credit_level, 2) == 0.91
    assert round(analytics.high_attendance_low_gpa_rate, 2) == 0.23
    assert analytics.low_atendance_and_low_gpa_rate == 0
    assert round(analytics.support_necessity_level, 2) == 30.4


def create_student_4():
    # 3年前期で行われた面談で、GPAが低い学生
    user_model = UserModel(
        id=uuid4(),
        name="藤崎暖",
        email="a1119331@kanazawa-it.ac.jp",
        is_admin=False
    )
    student_model = StudentModel(
        id=uuid4(),
        user_id=user_model.id,
        student_id="1119059",
        department="情報工学部",
        semester=5
    )
    interview_session = InterviewSessionModel(
        id=uuid4(),
        user_id=user_model.id,
        teacher_id=uuid4(),
        start_at=datetime.now(),
        progress=6,
        done=True
    )
    interview_record = InterviewRecordModel(
        id=uuid4(),
        session_id=interview_session.id,
        total_earned_credits=64,
        planned_credits=22,
        gpa=1.9,
        attendance_rate=70,
        concern=None,
        prefer_in_person_interview=False
    )
    return user_model, student_model, interview_session, interview_record


def test_student_4():
    _, student, _, record = create_student_4()
    analytics = InterviewAnalyticsModel.create_from_interview_record(
        student, record)
    assert analytics.fail_to_move_to_next_grade == False
    assert analytics.deviation_from_minimum_attendance_rate == 0
    assert round(analytics.deviation_from_preferred_credit_level, 2) == 1.0
    assert analytics.high_attendance_low_gpa_rate == 0
    assert round(analytics.low_atendance_and_low_gpa_rate, 2) == 0.38
    assert round(analytics.support_necessity_level, 2) == 34.19
