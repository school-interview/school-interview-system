from pydantic import BaseModel
from sqlalchemy import UUID
from src.crud.base_crud import BaseCrud
from src.models import UserModel, User, UserUpdate, StudentModel, AdminModel
from sqlalchemy.orm import Session


class UsersCrud(BaseCrud[UserModel, User, UserUpdate]):

    def get_by_email(self, db_session: Session, email: str) -> UserModel:
        return db_session.query(UserModel).filter(UserModel.email == email).first()

    def get_with_student(self, db_session: Session, id: UUID) -> UserModel:
        return db_session.query(UserModel).filter(UserModel.id == id).join(StudentModel, UserModel.id == StudentModel.user_id, isouter=True).first()

    def get_with_admin(self, db_session: Session, id: UUID) -> UserModel:
        return db_session.query(UserModel).filter(UserModel.id == id).join(AdminModel, UserModel.id == AdminModel.user_id).first()
