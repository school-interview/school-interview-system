from src.crud.users_crud import UsersCrud
from src.models.db_models.user_model import UserModel
from test.crud_tests.seeding_fixtures import db_session

users_crud = UsersCrud(UserModel)


def test_get_user_with_student(db_session):
    users = users_crud.get_multi_with_student(db_session)
    assert len(users) > 0
    first_user = users[0]
    # assert first_user.student
