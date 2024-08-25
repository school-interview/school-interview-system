from fastapi import FastAPI
import socketio
app_fastapi = FastAPI()

sio = socketio.ASGIApp
