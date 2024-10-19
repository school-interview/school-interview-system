from typing import Optional
from uuid import UUID

from sqlalchemy import ForeignKey
from src.models import EntityBaseModel, User
from pydantic import BaseModel
from sqlalchemy.orm import mapped_column, Mapped, relationship


class Admin(BaseModel):
    id: UUID
    user_id: UUID
    user: Optional[User]


class AdminModel(EntityBaseModel):
    __tablename__ = "Admins"
    id: Mapped[UUID] = mapped_column(primary_key=True)
    user_id: Mapped[UUID] = mapped_column(ForeignKey("Users.id"))
    user = relationship("UserModel", backref="admin")


class AdminUpdate(BaseModel):
    pass
