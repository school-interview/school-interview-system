from fastapi import FastAPI, HTTPException
from starlette.middleware.base import BaseHTTPMiddleware
from src.controllers.rest_api.auth import CLINET_URL
import httpx
import requests

# 　↓ 参考
# https://github.com/fastapi/fastapi/discussions/9599#discussioncomment-7894175


# Endpoint mapping for reverse proxy
ENDPOINT_MAPPING = {
    "/client": CLINET_URL,
}


class ReverseProxyMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request, call_next):
        # Check if the path matches an endpoint in the mapping
        for path, target_host in ENDPOINT_MAPPING.items():
            if request.url.path.startswith(path):
                # Forward the request to the target server
                # target_url = f"{target_host}{request.url.path}"

                target_url = "http://host.docker.internal:8001"
                async with httpx.AsyncClient() as client:
                    response = await client.get(target_url, headers=dict(request.headers))
                # Return the response to the client
                return response

        # If no matching endpoint found, proceed with the normal routing
        response = await call_next(request)
        return response
