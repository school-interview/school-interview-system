import uuid
from mock_alchemy.mocking import UnifiedAlchemyMagicMock
from sqlalchemy import create_engine
from backend.test.crud_tests.seeding_fixtures import db_session
from src.models import EntityBaseModel, InterviewSessionModel, UserModel, Student, StudentModel
from src.crud import InterviewSessionsCrud, UsersCrud, StudentsCrud

users_crud = UsersCrud(UserModel)
students_crud = StudentsCrud(StudentModel)
interview_sessions_crud = InterviewSessionsCrud(InterviewSessionModel)


def test_get_multiple_interview_session(db_session):
    sessions = interview_sessions_crud.get_multi(db_session)
    exists_all = True
    for session in sessions:
        if not session:
            exists_all = False
    assert exists_all
    assert len(sessions) == 3
