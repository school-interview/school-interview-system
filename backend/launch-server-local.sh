#!/bin/zsh
poetry run uvicorn src.main:app_socketio --reload --port 8000