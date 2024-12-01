from typing import Dict, List
from uuid import UUID
import pytest
from test.model_tests.seeding_fixtures import db_session_module_scoped
from src.models import InterviewQuestionModel, InterviewQuestionGroupModel
from src.crud import InterviewQuestionsCrud,  InterviewQuestionGroupsCrud

interview_question_groups_crud = InterviewQuestionGroupsCrud(
    InterviewQuestionGroupModel)
interview_questions_crud = InterviewQuestionsCrud(InterviewQuestionModel)


@pytest.fixture(scope="module")
def groups_and_questions(db_session_module_scoped):
    question_groups = interview_question_groups_crud.get_multi_with_questions(
        db_session_module_scoped)
    questions = interview_questions_crud.get_multi(db_session_module_scoped)
    questions_by_group: Dict[UUID, List[InterviewQuestionModel]] = {}
    for group in question_groups:
        for question in questions:
            if question.group_id == group.id:
                if group.id not in questions_by_group:
                    questions_by_group[group.id] = []
                questions_by_group[group.id].append(question)
        questions_by_group[group.id].sort(key=lambda x: x.order)
    return question_groups, questions, questions_by_group


def test_compare_value(groups_and_questions):
    question_groups, questions, questions_by_group = groups_and_questions
    attendance_rate_question_group = question_groups[3]
    questions_in_attendance_rate_group = questions_by_group[attendance_rate_question_group.id]

    reason_for_low_attendance_rate_question = questions_in_attendance_rate_group[1]
    assert not reason_for_low_attendance_rate_question.compare_value(
        89,
        reason_for_low_attendance_rate_question.condition_left_operator,
        reason_for_low_attendance_rate_question.condition_left_operand,
        'left'
    )
    assert not reason_for_low_attendance_rate_question.compare_value(
        80,
        reason_for_low_attendance_rate_question.condition_left_operator,
        reason_for_low_attendance_rate_question.condition_left_operand,
        'left'
    )
    assert reason_for_low_attendance_rate_question.compare_value(
        79,
        reason_for_low_attendance_rate_question.condition_left_operator,
        reason_for_low_attendance_rate_question.condition_left_operand,
        'left'
    )
    assert reason_for_low_attendance_rate_question.compare_value(
        70,
        reason_for_low_attendance_rate_question.condition_left_operator,
        reason_for_low_attendance_rate_question.condition_left_operand,
        'left'
    )


def test_can_skip(groups_and_questions):
    question_groups, questions, questions_by_group = groups_and_questions

    credit_question_group_id = question_groups[0].id
    attendance_rate_question_group_id = question_groups[3].id
    # 発動条件がない質問のテスト
    credit_question = questions_by_group[credit_question_group_id][0]
    assert credit_question.can_skip(20)
    assert credit_question.can_skip(70)
    assert credit_question.can_skip(90)
    assert credit_question.can_skip(124)

    # 発動条件を持つ質問のテスト
    reason_for_low_attendance_rate_question = (
        questions_by_group[attendance_rate_question_group_id][1]
    )
    assert not reason_for_low_attendance_rate_question.can_skip(70)
    assert not reason_for_low_attendance_rate_question.can_skip(79)
    assert reason_for_low_attendance_rate_question.can_skip(80)
    assert reason_for_low_attendance_rate_question.can_skip(100)
