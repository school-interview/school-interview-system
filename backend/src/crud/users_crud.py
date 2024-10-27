from pydantic import BaseModel
from sqlalchemy import UUID
from src.crud.base_crud import BaseCrud
from src.models import UserModel, User, UserUpdate, StudentModel, AdminModel
from sqlalchemy.orm import Session, joinedload


class UsersCrud(BaseCrud[UserModel, User, UserUpdate]):

    def get_by_email(self, db_session: Session, email: str) -> UserModel:
        return db_session.query(UserModel).filter(UserModel.email == email).first()

    def get_with_student(self, db_session: Session, id: UUID) -> UserModel:
        return db_session.query(UserModel).filter(UserModel.id == id).options(joinedload(UserModel.student)).join(StudentModel,  StudentModel.user_id == UserModel.id, isouter=True).first()

    def get_with_admin(self, db_session: Session, id: UUID) -> UserModel:
        return db_session.query(UserModel).filter(UserModel.id == id).options(joinedload(UserModel.admin)).join(AdminModel, AdminModel.user_id == UserModel.id, isouter=True).first()
