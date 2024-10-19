from typing import Optional
from pydantic import BaseModel
from src.models.db_models.user_model import User
from src.models.db_models.admin_model import Admin
from src.models.db_models.student_model import Student
from src.models.app_pydantic_base_model import AppPydanticBaseModel


class LoginResult(AppPydanticBaseModel):
    id_token: str
    refresh_token: str
    user: User
    student: Optional[Student] = None
    admin: Optional[Admin] = None
