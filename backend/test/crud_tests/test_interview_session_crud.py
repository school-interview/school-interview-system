import uuid
from mock_alchemy.mocking import UnifiedAlchemyMagicMock
from sqlalchemy import create_engine
from test.crud_tests.seedings import seed_all, seed_users
from src.models import EntityBaseModel, InterviewSessionModel, UserModel, Student, StudentModel
from src.crud import InterviewSessionsCrud, UsersCrud, StudentsCrud
engine = create_engine('sqlite:///:memory:', echo=True)
db_session = UnifiedAlchemyMagicMock()
engine.connect()
EntityBaseModel.metadata.create_all(engine)
users_crud = UsersCrud(UserModel)
students_crud = StudentsCrud(StudentModel)
interview_sessions_crud = InterviewSessionsCrud(InterviewSessionModel)
seed_all(db_session)


def test_get_multiple_interview_session():
    sessions = interview_sessions_crud.get_multi(db_session)
    exists_all = True
    for session in sessions:
        if not session:
            exists_all = False
    assert exists_all
    assert len(sessions) == 3
