import uuid
from src.models import UserModel, StudentModel
from src.crud import UsersCrud
from sqlalchemy.orm import Session

users_crud = UsersCrud(UserModel)


def seed_users(db_session: Session):
