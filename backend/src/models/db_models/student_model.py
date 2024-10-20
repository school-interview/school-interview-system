from uuid import UUID
from sqlalchemy import ForeignKey, String
from typing import Optional
from sqlalchemy.orm import mapped_column, Mapped, relationship
from pydantic import BaseModel, Field
from src.models.db_models.base_model import EntityBaseModel
from src.models.db_models.user_model import User
from src.models.app_pydantic_base_model import AppPydanticBaseModel


class Student(AppPydanticBaseModel):
    id: UUID
    user_id: UUID
    user: Optional[User]
    student_id: str
    department: str
    semester: int = Field(ge=1, le=8)


class StudentModel(EntityBaseModel):
    __tablename__ = "Students"
    id: Mapped[UUID] = mapped_column(primary_key=True)
    user_id: Mapped[UUID] = mapped_column(ForeignKey("Users.id"))
    user = relationship("UserModel", backref="student")
    student_id: Mapped[Optional[str]] = mapped_column(String(7))
    department: Mapped[Optional[str]] = mapped_column(String(30))
    semester: Mapped[Optional[int]]


class StudentUpdate(AppPydanticBaseModel):
    student_id: str
    department: str
    semester: int
