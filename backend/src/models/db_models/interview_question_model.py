from uuid import UUID
from src.models.db_models.base_model import EntityBaseModel
from typing import Any, Literal, Optional
from sqlalchemy import ForeignKey, String
from sqlalchemy.orm import mapped_column, Mapped, relationship
from src.models.app_pydantic_base_model import AppPydanticBaseModel
from sqlalchemy.orm import Session


class InterviewQuestion(AppPydanticBaseModel):
    id: UUID
    question: str
    order: int
    group_id: UUID
    condition_target_operand_data_type: Optional[Literal['int',
                                                         'float', 'str', 'bool']]
    condition_left_operand: Optional[str]
    condition_left_operator: Optional[Literal['==',
                                              '>', '<', '>=', '<=', '!=']]
    condition_right_operand: Optional[str]
    condition_right_operator: Optional[Literal['==',
                                               '>', '<', '>=', '<=', '!=']]
    prompt: str
    description: Optional[str]
    extraction_data_type: Literal['int', 'float', 'str', 'bool']


class InterviewQuestionModel(EntityBaseModel):
    __tablename__ = "InterviewQuestions"
    id: Mapped[UUID] = mapped_column(primary_key=True)
    group_id: Mapped[UUID] = mapped_column(
        ForeignKey("InterviewQuestionGroups.id", ondelete="CASCADE"))
    question: Mapped[str] = mapped_column(String(100))
    order: Mapped[int] = mapped_column(unique=True)
    condition_target_operand_data_type: Mapped[Optional[str]] = mapped_column(
        String(5))
    condition_left_operand: Mapped[Optional[str]] = mapped_column(String(10))
    condition_left_operator: Mapped[Optional[str]] = mapped_column(String(2))
    condition_right_operand: Mapped[Optional[str]] = mapped_column(String(10))
    condition_right_operator: Mapped[Optional[str]] = mapped_column(String(2))
    prompt: Mapped[str] = mapped_column(String(200))
    description: Mapped[Optional[str]] = mapped_column(String(200))
    extraction_data_type: Mapped[str] = mapped_column(String(5))
    interview_sessions = relationship("InterviewSessionModel",
                                      back_populates="current_question")
    interview_records = relationship(
        "InterviewRecordModel", back_populates="question")

    def can_skip(self, previous_question_extracted_value: Any) -> bool:
        """この質問をスキップできるかどうかを判定します。

        面談の質問は前の質問の回答に基づいて次の質問に進むかどうかを判定するため、このメソッドでは前の質問の回答からこの質問をスキップするかどうかを判定します。


        Args:
            value (Any): 回答する値

        Returns:
            bool: スキップできるかどうか
        Raises:

        """
        is_skippable = True
        if self.condition_left_operand and self.condition_left_operator:
            # 条件に当てはまる場合はスキップさせたくないので not で反転させています。
            is_skippable = not self.compare_value(
                previous_question_extracted_value, self.condition_left_operator, self.condition_left_operand, 'left')

        if is_skippable and self.condition_right_operand and self.condition_right_operator:
            is_skippable = not self.compare_value(
                previous_question_extracted_value, self.condition_right_operator, self.condition_right_operand, 'right')

        return is_skippable

    def compare_value(self, value: Any, operator: Literal['==', '>', '<', '>=', '<=', '!='], operand: str, operand_position: Literal['left', 'right']):
        """指定された値と演算子、オペランドで比較を行います。

        Args:
            value (Any): 回答する値
            operator (Literal['==','>', '<', '>=', '<=', '!=']): 演算子
            operand (str): オペランド(比較する値)

        Returns:
            None

        Raises:
            ValueError: 演算子が不正な場合
        """
        match self.condition_target_operand_data_type:
            case 'bool':
                operand = bool(operand)
            case 'int':
                operand = int(operand)
            case 'float':
                operand = float(operand)
            case 'str':
                operand = str(operand)

        is_operand_left = operand_position == 'left'

        if operator == '==':
            return operand == value if is_operand_left else value == operand
        elif operator == '>':
            return operand > value if is_operand_left else value > operand
        elif operator == '<':
            return operand < value if is_operand_left else value < operand
        elif operator == '>=':
            return operand >= value if is_operand_left else value >= operand
        elif operator == '<=':
            return operand <= value if is_operand_left else value <= operand
        elif operator == '!=':
            return operand != value if is_operand_left else value != operand
        raise ValueError("Invalid operator.")


class InterviewQuestionUpdate(AppPydanticBaseModel):
    question: str
    order: int
    prompt: str
    description: str
