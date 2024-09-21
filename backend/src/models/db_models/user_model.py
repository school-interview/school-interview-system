from uuid import UUID
from src.models import EntityBaseModel
from sqlalchemy import String
from typing import List
from sqlalchemy.orm import mapped_column, Mapped, relationship
from pydantic import BaseModel, Field


class User(BaseModel):
    id: UUID
    name: str
    student_id: str
    department: str
    semester: int = Field(ge=1, le=8)


class UserModel(EntityBaseModel):
    __tablename__ = "Users"
    id: Mapped[UUID] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(String(30))
    student_id: Mapped[str] = mapped_column(String(7))
    department: Mapped[str] = mapped_column(String(30))
    semester: Mapped[int]
