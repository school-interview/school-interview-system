from uuid import UUID
from src.models.app_pydantic_base_model import AppPydanticBaseModel
from src.models import EntityBaseModel
from sqlalchemy import Boolean, String
from typing import Any, List, Optional
from sqlalchemy.orm import mapped_column, Mapped, relationship
from pydantic import Field


class User(AppPydanticBaseModel):
    id: UUID
    name: str
    email: str
    is_admin: bool
    # 本当は型を指定したいけどcircular importになるのでAnyにしている...
    student: Optional[Any] = Field(None)
    admin: Optional[Any] = Field(None)


class UserModel(EntityBaseModel):
    __tablename__ = "Users"
    __allow_unmapped__ = True
    id: Mapped[UUID] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(String(60))
    email: Mapped[str] = mapped_column(String(254))
    is_admin: Mapped[bool] = mapped_column(Boolean)
    student: Optional[Any] = None
    admin: Optional[Any] = None


class UserUpdate(AppPydanticBaseModel):
    name: str
    email: str
