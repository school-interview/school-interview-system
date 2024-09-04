#!/bin/bash
echo "Start migrating database..."
poetry run alembic upgrade head
echo "Database migrated successfully"
# 一時的にDBだけ起動しておきたいのでコメントアウト
# poetry run uvicorn src.main:app_socketio --reload --host 0.0.0.0 --port 8000