from typing import Optional
from uuid import UUID
from src.models import EntityBaseModel, User
from pydantic import BaseModel
from sqlalchemy.orm import mapped_column, Mapped, relationship


class Admin(BaseModel):
    id: UUID
    user_id: UUID
    user: Optional[User]


class AdminModel(EntityBaseModel):
    __tablename__ = "Admins"
    id: Mapped[UUID]
    user_id: Mapped[UUID]
    user = relationship("UserModel", backref="admin")
