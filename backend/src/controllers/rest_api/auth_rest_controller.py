from fastapi import Depends
from src.database import session_factory
from src.models import RestApiController, HttpMethod, LoginRequest, User
from typing import List
from src.usecases.auth.login import login
from sqlalchemy.orm import Session


class LoginRestApiController(RestApiController):
    method = "PUT"
    path = "/login"

    async def controller(login_request: LoginRequest, session: Session = Depends(session_factory)):
        user = login(session, login_request)
        return user


auth_rest_api_controllers: List[RestApiController] = [
    LoginRestApiController()
]
