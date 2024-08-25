import asyncio
import socketio
import datetime
# これはWebsocketが使える環境かどうかテストするためのスクリプトです。

sio = socketio.AsyncClient(reconnection=False)


@sio.event
async def connect():
    print("WS接続成功")


@sio.event
async def disconnect():
    print("WS接続切断")


@sio.on('ping')
async def on_ping(data):
    print('on_ping: ', data)


async def main():
    await sio.connect('ws://localhost:8000')
    await sio.emit("message", {"data": "これがメッセージです。東京ディズニー{}".format(datetime.datetime.now())})
    await sio.disconnect()


asyncio.run(main())
