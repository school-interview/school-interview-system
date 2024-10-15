from uuid import UUID
from src.models import EntityBaseModel, User
from sqlalchemy import ForeignKey, String
from typing import Optional
from sqlalchemy.orm import mapped_column, Mapped, relationship
from pydantic import BaseModel, Field


class Student(BaseModel):
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
    student_id: Mapped[str] = mapped_column(String(7))
    department: Mapped[str] = mapped_column(String(30))
    semester: Mapped[int]
