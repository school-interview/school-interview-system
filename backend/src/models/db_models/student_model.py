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
    user: Optional[User] = None
    student_id: Optional[str]
    department: Optional[str]
    semester: Optional[int] = Field(ge=1, le=8)


class StudentModel(EntityBaseModel):
    __tablename__ = "Students"
    id: Mapped[UUID] = mapped_column(primary_key=True)
    user_id: Mapped[UUID] = mapped_column(ForeignKey("Users.id"))
    user: Mapped["User"] = relationship("UserModel", back_populates="student")
    student_id: Mapped[Optional[str]] = mapped_column(String(7))
    department: Mapped[Optional[str]] = mapped_column(String(30))
    semester: Mapped[Optional[int]]


class StudentUpdate(AppPydanticBaseModel):
    student_id: str
    department: str
    semester: int
