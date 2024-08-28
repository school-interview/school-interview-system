from database import connect_db
from fastapi import FastAPI
import socketio
import asyncio


app_fastapi = FastAPI()

print("現在のタスク", asyncio.current_task())


async def startup():
    await connect_db()


sio = socketio.AsyncServer(async_mode='asgi')
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
