from uuid import UUID
from src.models.db_models.base_model import EntityBaseModel
from sqlalchemy import String
from sqlalchemy.orm import mapped_column, Mapped, relationship
from src.models.app_pydantic_base_model import AppPydanticBaseModel


class Teacher(AppPydanticBaseModel):
    id: UUID
    name: str
    description: str


class TeacherModel(EntityBaseModel):
    __tablename__ = "Teachers"
    id: Mapped[UUID] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(String(30))
    description: Mapped[str] = mapped_column(String(100))


class TeacherUpdate(AppPydanticBaseModel):
    name: str
    description: str
