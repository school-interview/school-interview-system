from pydantic import BaseModel
from src.crud.base_crud import BaseCrud
from src.models import UserModel, User, UserUpdate
from sqlalchemy.orm import Session


class UserCrud(BaseCrud[UserModel, User, UserUpdate]):

    def get_by_emmail(self, db_session: Session, email: str) -> UserModel:
        return db_session.query(UserModel).filter(UserModel.email == email).first()
