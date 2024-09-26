from typing import List

from fastapi import Depends
from pydantic import TypeAdapter
from sqlalchemy.orm import Session
from src.database import session_factory
from src.models.db_models.user_model import User, UserModel
from src.models import RestApiController


class UsersRestApiController(RestApiController):
    method = "GET"
    path = "/users"
    response_model = List[User]

    async def controller(self, db_session: Session = Depends(session_factory)):
        user_query = db_session.query(UserModel)
        users = [TypeAdapter(User).validate_python(
            user[0].__dict__) for user in db_session.execute(user_query).all()]
        return users


user_rest_api_controllers: List[RestApiController] = [UsersRestApiController()]
