from uuid import UUID
from src.models import EntityBaseModel, User
from sqlalchemy import String, ForeignKey
from typing import List, Optional
from sqlalchemy.orm import mapped_column, Mapped, relationship
from pydantic import BaseModel


class InterviewRecord(BaseModel):
    id: UUID
    session_id: UUID
    total_earned_credits: Optional[int]
    planned_credits: Optional[int]
    gpa: Optional[float]
    attendance_rate: Optional[float]
    concern: Optional[str]
    prefer_in_person_interview: Optional[bool]


class InterviewRecordModel(EntityBaseModel):
    __tablename__ = "InterviewRecords"
    id: Mapped[UUID] = mapped_column(primary_key=True)
    session_id: Mapped[UUID] = mapped_column(
        ForeignKey("InterviewSessions.id"))
    session = relationship("InterviewSessionModel",
                           backref="interview_records")
    total_earned_credits: Mapped[Optional[int]]
    planned_credits: Mapped[Optional[int]]
    gpa: Mapped[Optional[float]]
    attendance_rate: Mapped[Optional[float]]
    concern: Mapped[Optional[str]]
    prefer_in_person_interview: Mapped[Optional[bool]]

    def calculate_support_necessity_level(self, user: User):
        # 算出方法に関してはこちら。
        # 今回は後期と仮定しています。なのでセミスターごとの処理の振り分けは行っておりません。本当はやらないといけないです。
        # https://www.notion.so/2024-09-17-104879aba7c6808cbcdfda7522e0d237

        # 各学年の進級条件単位数
        required_credits = {
            1: 30,  # 1 -> 2
            2: 62,  # 2 -> 3
            3: 110,  # 3 -> 4
        }
        # 各学年の推奨獲得単位数
        preffered_credits = {
            0: 0,
            1: 40,
            2: 85,
            3: 116,
            4: 124
        }

        level = 0

        def is_failed_to_move_to_next_grade():
            credits_to_be_earned_in_total = self.planned_credits + self.total_earned_credits
            if credits_to_be_earned_in_total < required_credits[user.grade]:
                return 100
            return 0

        def get_deviation_from_preferred_credit_level():
            credits_to_be_earned_in_total = self.planned_credits + self.total_earned_credits
            if credits_to_be_earned_in_total < preffered_credits[user.grade]:
                deviation = (preffered_credits[user.grade] - self.planned_credits)/(
                    preffered_credits[user.grade] - self.required_credits[user.grade])
                return deviation
            return 0

        def get_deviation_from_minimum_attendance_rate():
            if self.attendance_rate < 66:
                deviation = (66 - self.attendance_rate)/66
                return deviation
            return 0

        def get_high_attendance_low_gpa_rate():
            if self.attendance_rate >= 80 and self.gpa < 2.0:
                deviation = (2.0 - self.gpa)/(2.0)
                return deviation
            return 0

        def get_low_atendance_and_low_gpa_rate():
            if 66 <= self.attendance_rate and self.attendance_rate < 80 and self.gpa < 2.0:
                attendance_rate_deviation = (80-self.attendance_rate)/80-66
                gpa_deviation = (2.0 - self.gpa)/2.0
                avg_deviation = (attendance_rate_deviation +
                                 gpa_deviation)/2  # 平均を取る
                return avg_deviation
            return 0

        level += is_failed_to_move_to_next_grade()  # 進級できない場合は即座100プラスされるので係数はかけない
        level += get_deviation_from_preferred_credit_level() * \
            32.5  # 以下の項目に関しては要支援具合に応じて係数をかける。
        level += get_deviation_from_minimum_attendance_rate() * 27.5
        level += get_high_attendance_low_gpa_rate() * 22.5
        level += get_low_atendance_and_low_gpa_rate() * 17.5
        if level > 100:
            level = 100
        return level
