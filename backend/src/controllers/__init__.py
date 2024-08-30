from typing import List
from src.controllers.rest_api.auth_controller import auth_controllers
from src.models import RestApiController, HttpMethod, LoginRequest

rest_api_controllers: List[RestApiController] = [*auth_controllers]
