Write-Output "Start migrating database..."
poetry run alembic upgrade head
Write-Output "Database migrated successfully"

if ($env:DEBUG -eq "True") {
    Write-Output "Debug mode is on"
    poetry run python -m debugpy --listen 0.0.0.0:5678 -m uvicorn src.main:app_socketio --reload --host '0.0.0.0' --port 8000
} else {
    Write-Output "Debug mode is off"
    poetry run uvicorn src.main:app_socketio --reload --host 0.0.0.0 --port 8000
}
