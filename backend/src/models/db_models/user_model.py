from uuid import UUID
from src.models import EntityBaseModel
from sqlalchemy import Boolean, String
from typing import List
from sqlalchemy.orm import mapped_column, Mapped, relationship
from pydantic import BaseModel, Field


class User(BaseModel):
    id: UUID
    name: str
    email: str
    is_admin: bool


class UserModel(EntityBaseModel):
    __tablename__ = "Users"
    id: Mapped[UUID] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(String(60))
    email: Mapped[str] = mapped_column(String(254))
    is_admin: Mapped[bool] = mapped_column(Boolean)
