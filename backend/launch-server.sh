#!/bin/ash
poetry run uvicorn api.main:app_socketio --reload --host 0.0.0.0 --port 8000