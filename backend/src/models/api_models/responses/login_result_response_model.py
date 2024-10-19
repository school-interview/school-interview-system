from typing import Optional
from pydantic import BaseModel
from src.models.db_models.user_model import User
from src.models.db_models.admin_model import Admin
from src.models.db_models.student_model import Student


class LoginResult(BaseModel):
    id_token: str
    refresh_token: str
    user: User
    student: Optional[Student]
    admin: Optional[Admin]
