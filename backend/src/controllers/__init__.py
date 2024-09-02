from typing import List
from src.controllers.rest_api.auth_rest_controller import auth_rest_api_controllers
from src.models import RestApiController, WebsocketController
from src.controllers.websocket.interview_websocket_controller import interview_websocket_controllers
from src.controllers.websocket.connection_websocket_controller import connection_websocket_controllers


rest_api_controllers: List[RestApiController] = [*auth_rest_api_controllers]
websocket_controllers: List[WebsocketController] = [
    *interview_websocket_controllers, *connection_websocket_controllers]
