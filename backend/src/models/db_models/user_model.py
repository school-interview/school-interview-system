from uuid import UUID
from src.models.app_pydantic_base_model import AppPydanticBaseModel
from src.models.db_models.base_model import EntityBaseModel
from sqlalchemy import Boolean, String
from typing import TYPE_CHECKING, Any, ForwardRef, List, Optional
from sqlalchemy.orm import mapped_column, Mapped, relationship
from pydantic import Field
# if TYPE_CHECKING:
#     from src.models.db_models.student_model import Student
#     from src.models.db_models.admin_model import Admin
# Student = ForwardRef('Student')
# Admin = ForwardRef('Admin')


class User(AppPydanticBaseModel):
    id: UUID
    name: str
    email: str
    is_admin: bool
    # 本当は型を指定したいけどcircular importになるのでAnyにしている...
    student: Optional[Any] = None  # type: ignore
    admin: Optional[Any] = None  # type: ignore


class UserModel(EntityBaseModel):
    __tablename__ = "Users"
    __allow_unmapped__ = True
    id: Mapped[UUID] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(String(60))
    email: Mapped[str] = mapped_column(String(254))
    is_admin: Mapped[bool] = mapped_column(Boolean)
    student: Mapped[Optional[Any]] = relationship(
        "StudentModel", back_populates="user", cascade="all, delete-orphan")
    admin: Mapped[Optional[Any]] = relationship(
        "AdminModel", back_populates="user", cascade="all, delete-orphan")


class UserUpdate(AppPydanticBaseModel):
    name: str
    email: str


class UserRoleUpdate(AppPydanticBaseModel):
    is_admin: bool
