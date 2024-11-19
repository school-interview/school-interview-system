from typing import Optional
from uuid import UUID, uuid4
from pydantic import Field
from sqlalchemy import ForeignKey
from sqlalchemy.orm import mapped_column, Mapped, relationship
from src.models.db_models.base_model import EntityBaseModel
from src.models.db_models.interview_record_model import InterviewRecordModel
from src.models.db_models.interview_session_model import InterviewSession
from src.models.db_models.student_model import StudentModel
from src.models.app_pydantic_base_model import AppPydanticBaseModel


class InterviewAnalytics(AppPydanticBaseModel):
    id: UUID
    session_id: UUID
    session: Optional[InterviewSession] = Field(None)
    fail_to_move_to_next_grade: bool
    deviation_from_preferred_credit_level: float
    deviation_from_minimum_attendance_rate: float
    high_attendance_low_gpa_rate: float
    low_atendance_and_low_gpa_rate: float
    support_necessity_level: float
    advise: Optional[str] = Field(None)


class InterviewAnalyticsModel(EntityBaseModel):
    __tablename__ = "InterviewAnalytics"
    id: Mapped[UUID] = mapped_column(primary_key=True)
    session_id: Mapped[UUID] = mapped_column(
        ForeignKey("InterviewSessions.id", ondelete="CASCADE"))
    session = relationship("InterviewSessionModel", backref="analytics")
    fail_to_move_to_next_grade: Mapped[bool]
    deviation_from_preferred_credit_level: Mapped[float]
    deviation_from_minimum_attendance_rate: Mapped[float]
    high_attendance_low_gpa_rate: Mapped[float]
    low_atendance_and_low_gpa_rate: Mapped[float]
    support_necessity_level: Mapped[float]
    advise: Mapped[Optional[str]]

    @staticmethod
    def create_from_interview_record(student: StudentModel, interview_record: InterviewRecordModel):
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
            if credits_to_be_earned_in_total < required_credits[student.semester]:
                return 100
            return 0

        def get_deviation_from_preferred_credit_level():
            credits_to_be_earned_in_total = planned_credits + total_earned_credits
            if credits_to_be_earned_in_total < preffered_credits[student.semester]:
                if student.semester == 8:  # semesterが8の場合は124かどうかで判断
                    return 0 if credits_to_be_earned_in_total < 124 else 1
                deviation = (preffered_credits[student.semester] - credits_to_be_earned_in_total)/(
                    preffered_credits[student.semester] - required_credits[student.semester])
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
                attendance_rate_deviation = (80 - attendance_rate)/(80-66)
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
            support_necessity_level=level,
            advise=InterviewAnalyticsModel.generate_advise(failed_to_move_to_next_grade, deviation_from_preferred_credit_level,
                                                           deviation_from_minimum_attendance_rate, high_attendance_low_gpa_rate, low_atendance_and_low_gpa_rate)
        )

    @staticmethod
    def generate_advise(fail_to_move_to_next_grade: bool, deviation_from_preferred_credit_level: float, deviation_from_minimum_attendance_rate: float, high_attendance_low_gpa_rate: float, low_atendance_and_low_gpa_rate: float):
        advise = ""
        if fail_to_move_to_next_grade:
            advise += """
✅ 進級について
進級できない可能性があります。担当教員との面談をお勧めします。
"""
        if deviation_from_preferred_credit_level < 1:
            advise += """
✅ 単位取得について
次学期終了時点での予定単位取得数が推奨単位数に達していません。単位取得についての計画を立てることをお勧めします。
"""
        if deviation_from_minimum_attendance_rate > 0:
            advise += """
✅ 出席率について
出席率が66%を下回っています。もし出席し辛い事情がありましたら、担当教員に相談することができます。
"""
        if high_attendance_low_gpa_rate > 0:
            advise += """
✅ 成績向上にむけて
大学の施設を活用することをおすすめします！
・数理工教育研究センター 
数学、物理、化学などの学習に役立つ施設です。

・基礎英語教育センター（EEC） （23号館2・3階）
英語力向上に役に立ちます。

"""
        if low_atendance_and_low_gpa_rate > 0:
            advise += """
✅ 出席率と成績向上にむけて
出席し辛い事情がありましたら、担当教員に相談することができます。

また成績向上のために、大学の施設を活用することをおすすめします！
・数理工教育研究センター 
数学、物理、化学などの学習に役立つ施設です。

・基礎英語教育センター（EEC） （23号館2・3階）
英語力向上に役に立ちます。

"""
        return advise


class InterviewAnalyticsUpdate(AppPydanticBaseModel):
    fail_to_move_to_next_grade: bool
    deviation_from_preferred_credit_level: float
    deviation_from_minimum_attendance_rate: float
    high_attendance_low_gpa_rate: float
    low_atendance_and_low_gpa_rate: float
    support_necessity_level: float
