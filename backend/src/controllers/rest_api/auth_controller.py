from fastapi import Depends
from src.database import session_factory
from src.models import RestApiController, HttpMethod, LoginRequest
from typing import List
from usecases.auth.login import login
from sqlalchemy.orm import Session


def login_controller(login_request: LoginRequest, session: Session = Depends(session_factory)):
    return login(session, login_request)


auth_controllers: List[RestApiController] = [
    RestApiController("PUT", "/login", login_controller)
]
