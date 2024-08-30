from typing import List
from src.controllers.rest_api.auth_controller import auth_controllers
from src.models import RestApiController, HttpMethod, LoginRequest
from src.controllers.websocket.interview_controller import websocket_controllers
from src.models.websocket_controller_model import WebsocketController


rest_api_controllers: List[RestApiController] = [*auth_controllers]
websocket_controllers: List[WebsocketController] = [*websocket_controllers]
