from dotenv import load_dotenv
from src.database import SessionMaker, connect_db
from fastapi import FastAPI
import socketio
import asyncio
from contextlib import asynccontextmanager
from src.controllers import rest_api_controllers
from src.controllers import websocket_controllers
import logging
from src.websocket_server import sio

logging.basicConfig(level=logging.INFO)

load_dotenv(".env")
load_dotenv(".env.local")

connect_db()


@asynccontextmanager
async def lifespan(app: FastAPI):
    # RestAPIのコントローラを登録
    for rest in rest_api_controllers:
        print(rest.path, rest.method, flush=True)
        app.add_api_route(
            path=rest.path,
            endpoint=rest.controller,
            methods=[rest.method],
            response_model=rest.response_model if hasattr(
                rest, "response_model") else None
        )
    # Websocketのコントローラを登録
    for ws in websocket_controllers:
        sio.on(ws.event_name, ws.controller)
    yield


app_fastapi = FastAPI(lifespan=lifespan)

app_socketio = socketio.ASGIApp(sio, other_asgi_app=app_fastapi)
