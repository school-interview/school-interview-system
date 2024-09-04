#!/bin/zsh
echo "Start migrating database..."
poetry run alembic upgrade head
echo "Database migrated successfully"
poetry run uvicorn src.main:app_socketio --reload --port 8000