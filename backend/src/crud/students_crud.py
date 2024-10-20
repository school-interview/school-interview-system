from sqlalchemy import UUID
from src.models import StudentModel, Student, StudentUpdate
from src.crud.base_crud import BaseCrud
from sqlalchemy.orm import Session


class StudentsCrud(BaseCrud[StudentModel, Student, StudentUpdate]):
    def get_by_user_id(self, db_session: Session, user_id: UUID) -> StudentModel:
        return db_session.query(StudentModel).filter(StudentModel.user_id == user_id).first()
