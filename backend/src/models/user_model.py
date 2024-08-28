from models.base_model import ModelBase
from sqlalchemy import String
from sqlalchemy.orm import mapped_column, Mapped


class User(ModelBase):
    __tablename__ = "Users"
    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(String(30))
    studentId: Mapped[str] = mapped_column(String(7))
    department: Mapped[str] = mapped_column(String(30))
    grade: Mapped[int]
