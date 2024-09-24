from typing import Optional
from uuid import UUID, uuid4
from pydantic import BaseModel, Field
from sqlalchemy import ForeignKey
from src.models import InterviewSession, EntityBaseModel, UserModel, InterviewRecordModel
from sqlalchemy.orm import mapped_column, Mapped, relationship


class InterviewAnalytics(BaseModel):
    id: UUID
    session_id: UUID
    session: Optional[InterviewSession] = Field(None)
    fail_to_move_to_next_grade: bool
    deviation_from_preferred_credit_level: float
    deviation_from_minimum_attendance_rate: float
    high_attendance_low_gpa_rate: float
    low_atendance_and_low_gpa_rate: float
    support_necessity_level: float


class InterviewAnalyticsModel(EntityBaseModel):
    __tablename__ = "InterviewAnalytics"
    id: Mapped[UUID] = mapped_column(primary_key=True)
    session_id: Mapped[UUID] = mapped_column(
        ForeignKey("InterviewSessions.id"))
    session = relationship("InterviewSessionModel", backref="analytics")
    fail_to_move_to_next_grade: Mapped[bool]
    deviation_from_preferred_credit_level: Mapped[float]
    deviation_from_minimum_attendance_rate: Mapped[float]
    high_attendance_low_gpa_rate: Mapped[float]
    low_atendance_and_low_gpa_rate: Mapped[float]
    support_necessity_level: Mapped[float]

    @staticmethod
    def create_from_interview_record(user: UserModel, interview_record: InterviewRecordModel):
        # 算出方法に関してはこちら。
        # https://www.notion.so/2024-09-17-104879aba7c6808cbcdfda7522e0d237

        # 各学年の進級条件単位数
        required_credits = {
            1: 15,  # 1年前期
            2: 30,  # 1年後期
            3: 46,  # 2年前期
            4: 62,  # 2年後期
            5: 86,  # 3年前期
            6: 110,  # 3年後期
            7: 117,  # 4年前期
            8: 124,  # 4年後期
        }
        # 各学年の推奨獲得単位数
        preffered_credits = {
            1: 20,  # 1年前期
            2: 40,  # 1年後期
            3: 62.5,  # 2年前期
            4: 85,  # 2年後期
            5: 100.5,  # 3年前期
            6: 116,  # 3年後期
            7: 120,  # 4年前期
            8: 124,  # 4年後期
        }

        planned_credits = interview_record.planned_credits
        total_earned_credits = interview_record.total_earned_credits
        attendance_rate = interview_record.attendance_rate
        gpa = interview_record.gpa

        level = 0

        def is_failed_to_move_to_next_grade():
            credits_to_be_earned_in_total = planned_credits + total_earned_credits
            if credits_to_be_earned_in_total < required_credits[user.semester]:
                return 100
            return 0

        def get_deviation_from_preferred_credit_level():
            credits_to_be_earned_in_total = planned_credits + total_earned_credits
            preffered_credits_this_semester = preffered_credits[user.semester]-(
                preffered_credits[user.semester-1] if user.semester > 1 else 0)
            required_credits_this_semester = required_credits[user.semester]-(
                required_credits[user.semester-1] if user.semester > 1 else 0)
            if credits_to_be_earned_in_total < preffered_credits[user.semester]:
                deviation = (preffered_credits_this_semester - planned_credits)/(
                    preffered_credits_this_semester - required_credits_this_semester)
                return deviation
            return 0

        def get_deviation_from_minimum_attendance_rate():
            if attendance_rate < 66:
                deviation = (66 - attendance_rate)/66
                return deviation
            return 0

        def get_high_attendance_low_gpa_rate():
            if attendance_rate >= 80 and gpa < 2.0:
                deviation = (2.0 - gpa)/(2.0)
                return deviation
            return 0

        def get_low_atendance_and_low_gpa_rate():
            if 66 <= attendance_rate and attendance_rate < 80 and gpa < 2.0:
                attendance_rate_deviation = (80 - attendance_rate)/80-66
                gpa_deviation = (2.0 - gpa)/2.0
                avg_deviation = (attendance_rate_deviation +
                                 gpa_deviation)/2  # 平均を取る
                return avg_deviation
            return 0

        failed_to_move_to_next_grade = is_failed_to_move_to_next_grade() > 0
        deviation_from_preferred_credit_level = get_deviation_from_preferred_credit_level()
        deviation_from_minimum_attendance_rate = get_deviation_from_minimum_attendance_rate()
        high_attendance_low_gpa_rate = get_high_attendance_low_gpa_rate()
        low_atendance_and_low_gpa_rate = get_low_atendance_and_low_gpa_rate()

        # 進級できない場合は即座100プラスされるので係数はかけない
        level += 100 if failed_to_move_to_next_grade else 0
        level += deviation_from_minimum_attendance_rate * 32.5
        level += deviation_from_preferred_credit_level * \
            27.5    # 以下の項目に関しては要支援具合に応じて係数をかける。
        level += high_attendance_low_gpa_rate * 22.5
        level += low_atendance_and_low_gpa_rate * 17.5
        if level > 100:
            level = 100
        return InterviewAnalyticsModel(
            id=uuid4(),
            session_id=interview_record.session_id,
            fail_to_move_to_next_grade=failed_to_move_to_next_grade,
            deviation_from_preferred_credit_level=deviation_from_preferred_credit_level,
            deviation_from_minimum_attendance_rate=deviation_from_minimum_attendance_rate,
            high_attendance_low_gpa_rate=high_attendance_low_gpa_rate,
            low_atendance_and_low_gpa_rate=low_atendance_and_low_gpa_rate,
            support_necessity_level=level
        )
