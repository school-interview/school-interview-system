from datetime import datetime
from uuid import uuid4
from src.models import InterviewAnalyticsModel, UserModel, InterviewRecordModel, InterviewSessionModel


def create_student_1():
    # １年後期に行われた面談で、順調な学生
    user_model = UserModel(
        id=uuid4(),
        name="藤崎暖",
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
    return user_model, interview_session, interview_record


def test_student1():
    user, session, record = create_student_1()
    analytics = InterviewAnalyticsModel.create_from_interview_record(
        user, record)
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
    return user_model, interview_session, interview_record


def test_student2():
    user, _, record = create_student_2()
    analytics = InterviewAnalyticsModel.create_from_interview_record(
        user, record)
    assert analytics.fail_to_move_to_next_grade == False
    assert round(analytics.deviation_from_preferred_credit_level, 2) == 0.38
    assert analytics.deviation_from_minimum_attendance_rate == 0
    assert analytics.high_attendance_low_gpa_rate == 0
    assert analytics.low_atendance_and_low_gpa_rate == 0
    assert round(analytics.support_necessity_level, 2) == 10.58
