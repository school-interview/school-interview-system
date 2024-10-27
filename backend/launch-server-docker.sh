#!/bin/bash
echo "Start migrating database..."
poetry run alembic upgrade head
echo "Database migrated successfully"
if [ -n "$DEBUG" ] && [ "$DEBUG" = "True" ]; then
	echo "Debug mode is on"
	poetry run python -m debugpy --listen 0.0.0.0:5678 -m uvicorn src.main:app_socketio --reload --host '0.0.0.0' --port 8000
else
	echo "Debug mode is off"
	poetry run uvicorn src.main:app_socketio --reload --host 0.0.0.0 --port 8000
fi
