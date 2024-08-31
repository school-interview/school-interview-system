import asyncio
import socketio
import requests
from src.models import LoginRequest
# これはWebsocketが使える環境かどうかテストするためのスクリプトです。

login_request: LoginRequest = LoginRequest(
    student_id="1119059",
    name="藤崎暖",
    department="情報学部",
    grade=4
)
r = requests.put('http://localhost:8000/user', login_request)

sio = socketio.AsyncClient(reconnection=False)


@sio.event
async def connect():
    print("WS接続成功")


@sio.event
async def disconnect():
    print("WS接続切断")


async def main():
    await sio.connect('ws://localhost:8000')
    input_text = input("メッセージを入力：")
    await sio.emit("speak_to_teacher", {"data": input_text})
    await sio.disconnect()


asyncio.run(main())
