from uuid import UUID
from src.crud.base_crud import BaseCrud
from src.models import AdminModel, Admin, AdminUpdate
from sqlalchemy.orm import Session


class AdminCrud(BaseCrud[AdminModel, Admin, AdminUpdate]):
    def get_by_user_id(self, db_session: Session, user_id: UUID) -> AdminModel:
        return db_session.query(AdminModel).filter(AdminModel.user_id == user_id).first()
