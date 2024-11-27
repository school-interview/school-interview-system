from typing import Dict, List, Optional, TypedDict
from uuid import UUID, uuid4
from pydantic import Field
from sqlalchemy import ForeignKey
from sqlalchemy.orm import mapped_column, Mapped, relationship
from src.models.db_models.interview_question_model import InterviewQuestion
from src.models.db_models.interview_question_group_model import InterviewQuestionGroup
from src.models.db_models.base_model import EntityBaseModel
from src.models.db_models.interview_record_model import InterviewRecordModel, InterviewRecord
from src.models.db_models.interview_session_model import InterviewSession, InterviewSessionModel
from src.models.db_models.student_model import StudentModel
from src.models.app_pydantic_base_model import AppPydanticBaseModel


class InterviewExtractedValueDict(TypedDict):
    planned_credits: int
    total_earned_credits: int
    attendance_rate: float
    gpa: float


def interview_extracted_value_dict_factory(interview_records: List[InterviewRecordModel], groups: List[InterviewQuestionGroup]) -> InterviewExtractedValueDict:
    # TODO: InterviewRecordにhuman readableなID（'planned_credits'など）を追加するアプローチにしたい。
    order_key_mapping = {
        "1-1": "planned_credits",
        "2-1": "total_earned_credits",
        "3-1": "attendance_rate",
        "4-1": "gpa"
    }
    extracted_value_dict: InterviewExtractedValueDict = {
        'attendance_rate': 0,
        'gpa': 0,
        'planned_credits': 0,
        'total_earned_credits': 0
    }
    question_id_to_order: Dict[UUID, str] = {}
    question_id_to_question: Dict[UUID, InterviewQuestion] = {}
    for group in groups:
        if group.questions is None:
            raise ValueError(
                "Coundn't load questions in InterviewQuestionGroup.")
        for question in group.questions:
            question_id_to_order[question.id] = f"{
                group.order}-{question.order}"
            question_id_to_question[question.id] = question

    for record in interview_records:
        order = question_id_to_order[record.question_id]
        if order not in order_key_mapping:
            continue
        key = order_key_mapping[order]
        question = question_id_to_question[record.question_id]
        match question.extraction_data_type:
            case "int":
                extracted_value_dict[key] = int(record.extracted_data)
            case "float":
                extracted_value_dict[key] = float(record.extracted_data)
            case "str":
                extracted_value_dict[key] = record.extracted_data
            case "bool":
                extracted_value_dict[key] = bool(record.extracted_data)
            case _:
                raise ValueError(
                    "Invalid extraction data type in InterviewQuestion.")
    return extracted_value_dict


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

    @staticmethod
    def interview_analytics_factory(interview_session: InterviewSessionModel, student: StudentModel, extracted_value_dict: InterviewExtractedValueDict):
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

        planned_credits = extracted_value_dict['planned_credits']
        total_earned_credits = extracted_value_dict['total_earned_credits']
        attendance_rate = extracted_value_dict['attendance_rate']
        gpa = extracted_value_dict['gpa']

        level = 0

        def is_failed_to_move_to_next_grade():
            if student.semester is None:
                raise ValueError("semester doesn't exist in student model.")
            credits_to_be_earned_in_total = planned_credits + total_earned_credits
            if credits_to_be_earned_in_total < required_credits[student.semester]:
                return 100
            return 0

        def get_deviation_from_preferred_credit_level():
            if student.semester is None:
                raise ValueError("semester doesn't exist in student model.")
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
            session_id=interview_session.id,
            fail_to_move_to_next_grade=failed_to_move_to_next_grade,
            deviation_from_preferred_credit_level=deviation_from_preferred_credit_level,
            deviation_from_minimum_attendance_rate=deviation_from_minimum_attendance_rate,
            high_attendance_low_gpa_rate=high_attendance_low_gpa_rate,
            low_atendance_and_low_gpa_rate=low_atendance_and_low_gpa_rate,
            support_necessity_level=level
        )


class InterviewAnalyticsUpdate(AppPydanticBaseModel):
    fail_to_move_to_next_grade: bool
    deviation_from_preferred_credit_level: float
    deviation_from_minimum_attendance_rate: float
    high_attendance_low_gpa_rate: float
    low_atendance_and_low_gpa_rate: float
    support_necessity_level: float
