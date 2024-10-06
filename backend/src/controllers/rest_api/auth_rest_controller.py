import os
from fastapi import Depends, HTTPException, Query
from fastapi.security import OAuth2AuthorizationCodeBearer
from fastapi.responses import RedirectResponse
from src.database import session_factory
from src.models import RestApiController, HttpMethod, LoginRequest, User
from typing import List
from src.usecases.auth.login import login
from sqlalchemy.orm import Session
from dotenv import load_dotenv
import httpx

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
    path = "/oauth2/login/callback"
    response_model = None

    async def controller(self, code: str, session: Session = Depends(session_factory)):
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
            raise HTTPException(status_code=400, detail=token_response_json)
        return token_response_json


auth_rest_api_controllers: List[RestApiController] = [
    LoginRestApiController(),
    OAuthCallbackRestApiController()
]
