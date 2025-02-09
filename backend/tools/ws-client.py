import requests
import socketio
import asyncio
from src.models import User
from src.models import LoginRequest
import json

# これはWebsocketが使える環境かどうかテストするためのスクリプトです。

login_request: LoginRequest = LoginRequest(
    student_id="9998997",
    name="藤崎暖",
    department="情報学部",
    grade=4
)p0
response = requests.put('http://localhost:8000/login',
                        json=login_request.__dict__)
user: User = response.json()
print(user)
sio = socketio.AsyncClient(reconnection=False)


@sio.event
async def connect():
    print("WS接続成功", flush=True)


@sio.event
async def disconnect():
    print("WS接続切断", flush=True)


@sio.on("message")
async def message(data):
    print("メッセージ受信", data, flush=True)


@sio.on("message_from_teacher")
async def message(data):
    print("メッセージフロムティーチャー", data, flush=True)


@sio.on('*')
async def message_from_teacher(sid, data):
    print("先生からのメッセージ：", data, flush=True)


async def main():

    await sio.connect('http://localhost:8000', auth={'user_id': user['id']}, transports=['websocket'],
                      )
    print("あなたのsidは", sio.sid, flush=True)
    input_text = input("メッセージを入力：")
    await sio.emit("speak_to_teacher", input_text)
    await sio.wait()
    # a = input("終了するにはエンター")
    await sio.disconnect()

asyncio.run(main())
