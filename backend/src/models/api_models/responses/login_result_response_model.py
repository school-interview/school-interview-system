from typing import Optional
from pydantic import BaseModel, ConfigDict
from src.models.db_models.user_model import User
from src.models.db_models.admin_model import Admin
from src.models.db_models.student_model import Student
from pydantic.alias_generators import to_camel


class LoginResult(BaseModel):
    model_config = ConfigDict(alias_generator=to_camel,
                              populate_by_name=True)
    id_token: str
    refresh_token: str
    user: User
