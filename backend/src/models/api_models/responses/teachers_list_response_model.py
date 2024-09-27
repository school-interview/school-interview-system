from typing import List
from pydantic import BaseModel
from src.models.db_models.teacher_model import Teacher


class TeachersListResponse(BaseModel):
    teachers: List[Teacher]
    count: int
