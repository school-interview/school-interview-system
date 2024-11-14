from uuid import UUID
from src.crud import UsersCrud
from sqlalchemy.orm import Session
from src.models import UserModel


def delete_user(db_session: Session, user_id: UUID):
    users_crud = UsersCrud(UserModel)
    users_crud.remove(db_session, id=user_id)
