from datetime import datetime
from uuid import uuid4
from src.models import InterviewAnalyticsModel, UserModel, InterviewRecordModel, InterviewSessionModel, StudentModel


def create_student_1():
    # １年後期に行われた面談で、順調な学生
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
        semester=2
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
        total_earned_credits=20,
        planned_credits=20,
        gpa=3.0,
        attendance_rate=90,
        concern=None,
        prefer_in_person_interview=False
    )
    return user_model, student_model, interview_session, interview_record


def test_student1():
    _, student, _, record = create_student_1()
    analytics = InterviewAnalyticsModel.create_from_interview_record(
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
