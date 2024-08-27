from base import ModelBase
from sqlalchemy import String
from sqlalchemy.orm import mapped_column, Mapped


class User(ModelBase):
    __tablename__ = "users"
    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(String(30))
    studentId: Mapped[str] =
