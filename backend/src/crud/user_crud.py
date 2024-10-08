from pydantic import BaseModel
from src.crud.base_crud import CrudBase
from src.models import UserModel, User
from sqlalchemy.orm import Session


class UserCrud(CrudBase[UserModel, User, User]):

    def get_by_emmail(self, db_session: Session, email: str) -> UserModel:
        return db_session.query(UserModel).filter(UserModel.email == email).first()
