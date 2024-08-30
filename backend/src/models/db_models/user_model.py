from src.models import BaseModel
from sqlalchemy import String
from typing import List
from sqlalchemy.orm import mapped_column, Mapped, relationship


class User(BaseModel):
    __tablename__ = "Users"
    id: Mapped[str] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(String(30))
    student_id: Mapped[str] = mapped_column(String(7))
    department: Mapped[str] = mapped_column(String(30))
    grade: Mapped[int]
