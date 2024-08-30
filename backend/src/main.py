from database import connect_db
from fastapi import FastAPI
import socketio
import asyncio
from contextlib import asynccontextmanager
from controllers import rest_api_controllers
from sqlalchemy import Engine
from sqlalchemy.orm import sessionmaker


@asynccontextmanager
async def lifespan(app: FastAPI):
    for controller in rest_api_controllers:
        app.add_api_route(
            controller.path,
            controller.controller,
            methods=[controller.method]
        )
    yield


app_fastapi = FastAPI(lifespan=lifespan)


sio = socketio .AsyncServer(async_mode='asgi')
app_socketio = socketio.ASGIApp(sio, other_asgi_app=app_fastapi)


@app_fastapi.get("/")
async def index():
    return {"message": "Hello World"}


@app_fastapi.get("/ping/{sid}")
async def ping(sid: str):
    """指定されたsidにemitするエンドポイント
    """
    sio.start_background_task(
        sio.emit,
        "ping", {"message": "ping from server"}, room=sid)
    return {"result": "OK"}


@sio.event
async def connect(sid, data):
    print('接続 ', sid)


@sio.on("message")
async def message(sid, data):
    print("メッセージ from {}: {}".format(sid, data), flush=True)


@sio.event
async def disconnect(sid):
    print("接続が切れました", sid)
