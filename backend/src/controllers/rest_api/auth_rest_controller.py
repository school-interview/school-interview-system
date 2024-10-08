import os
from fastapi import Depends, HTTPException, Query, Request
from fastapi.security import OAuth2AuthorizationCodeBearer
from fastapi.responses import RedirectResponse
from src.database import session_factory
from src.models import RestApiController, ErrorResponse
from typing import Any, List
from src.usecases.auth.login import login
from sqlalchemy.orm import Session
from dotenv import load_dotenv
import httpx
from google.oauth2 import id_token
from google.auth.transport import requests

load_dotenv(".env.local")

CLIENT_ID = os.getenv("CLIENT_ID")
CLIENT_SECRET = os.getenv("CLIENT_SECRET")
REDIRECT_URI = os.getenv("REDIRECT_URI")
AUTHORIZATION_URL = "https://accounts.google.com/o/oauth2/v2/auth"
TOKEN_URL = "https://oauth2.googleapis.com/token"


oauth2_scheme = OAuth2AuthorizationCodeBearer(
    authorizationUrl=AUTHORIZATION_URL,
    tokenUrl=TOKEN_URL
)


async def verify_token(jwt: str):
    try:
        # TODO: 毎回certificatesをフェッチしているようなのでそれをキャッシュする
        # ↓　Issueのリンク
        # https://github.com/orgs/school-interview/projects/2/views/1?pane=issue&itemId=82535648&issue=school-interview%7Cschool-interview-system%7C123
        id_info = id_token.verify_oauth2_token(
            jwt, requests.Request(), CLIENT_ID
        )
    except ValueError:
        raise ErrorResponse(
            status_code=400,
            type="invalid_token",
            title="Invalid token",
            detail="The token provided is invalid."
        )
    return id_info


class LoginRestApiController(RestApiController):
    method = "GET"
    path = "/login"
    response_model = None

    async def controller(self, session: Session = Depends(session_factory)):
        auth_url = (f"{AUTHORIZATION_URL}"
                    f"?response_type=code&client_id={CLIENT_ID}&"
                    f"redirect_uri={REDIRECT_URI}&"
                    f"scope=openid%20email%20profile&"
                    f"access_type=offline&prompt=consent")
        return RedirectResponse(auth_url)


class OAuthCallbackRestApiController(RestApiController):
    method = "GET"
    path = "/oauth2/callback"
    response_model = Any

    async def controller(self, code: str, request: Request, session: Session = Depends(session_factory)):
        async with httpx.AsyncClient() as client:
            token_response = await client.post(TOKEN_URL, data={
                "code": code,
                "client_id": CLIENT_ID,
                "client_secret": CLIENT_SECRET,
                "redirect_uri": REDIRECT_URI,
                "grant_type": "authorization_code"
            })
        token_response_json = token_response.json()
        if token_response.is_error:
            raise ErrorResponse(
                status_code=400,
                type="failed_to_get_token",
                title="Failed to get token",
                detail=token_response_json.get("error_description")
            )
        id_token = token_response_json["id_token"]
        refresh_token = token_response_json["refresh_token"]
        id_info = await verify_token(id_token)
        request.session['id_token'] = id_token
        request.session['refresh_token'] = refresh_token
        return request.session['id_token']


auth_rest_api_controllers: List[RestApiController] = [
    LoginRestApiController(),
    OAuthCallbackRestApiController()
]
