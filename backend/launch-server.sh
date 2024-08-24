#!/bin/ash
poetry run uvicorn api.main:app --reload --host 0.0.0.0 --port 8000