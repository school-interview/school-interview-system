from typing import Any, Optional
from uuid import UUID

from sqlalchemy import ForeignKey
from src.models import EntityBaseModel, User
from pydantic import BaseModel
from sqlalchemy.orm import mapped_column, Mapped, relationship
from src.models.app_pydantic_base_model import AppPydanticBaseModel


class Admin(AppPydanticBaseModel):
    id: UUID
    user_id: UUID
    user: Optional[User]


class AdminModel(EntityBaseModel):
    __tablename__ = "Admins"
    id: Mapped[UUID] = mapped_column(primary_key=True)
    user_id: Mapped[UUID] = mapped_column(ForeignKey("Users.id"))
    user: Mapped[Any] = relationship("UserModel", back_populates="admin")


class AdminUpdate(BaseModel):
    pass
