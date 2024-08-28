from models.base_model import BaseModel
from typing import Optional
from sqlalchemy import String
from sqlalchemy.orm import mapped_column, Mapped, relationship


class InterviewQuestion(BaseModel):
    __tablename__ = "InterviewQuestions"
    id: Mapped[str] = mapped_column(primary_key=True)
    question: Mapped[str] = mapped_column(String(100))
    order: Mapped[int] = mapped_column(unique=True)
    description: Mapped[Optional[str]] = mapped_column(String(200))
