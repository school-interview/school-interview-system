import uuid
from uuid import UUID
from mock_alchemy.mocking import UnifiedAlchemyMagicMock
from sqlalchemy import create_engine
from test.crud_tests.seeding_fixtures import db_session
from src.models import EntityBaseModel, InterviewSessionModel, UserModel, Student, StudentModel, InterviewQuestionModel
from src.crud import InterviewSessionsCrud, UsersCrud, StudentsCrud, InterviewQuestionsCrud

users_crud = UsersCrud(UserModel)
students_crud = StudentsCrud(StudentModel)
interview_sessions_crud = InterviewSessionsCrud(InterviewSessionModel)
interview_questons_crud = InterviewQuestionsCrud(InterviewQuestionModel)


def test_get_multi_interview_session(db_session):
    sessions = interview_sessions_crud.get_multi(db_session)
    exists_all = True
    for session in sessions:
        if not session:
            exists_all = False
    assert exists_all
    assert len(sessions) == 3


def test_get_multi_with_current_question(db_session):
    users = users_crud.get_multi(db_session)
    first_user = users[0]
    interview_session = interview_sessions_crud.get_with_curernt_question(
        db_session, UUID(first_user.id))
    current_question = interview_questons_crud.get(
        db_session, UUID(interview_session.current_question_id))
    assert first_user
    assert interview_session
    assert interview_session.user_id == first_user.id
    assert current_question.id == UUID(interview_session.current_question_id)
    assert interview_session.current_question
