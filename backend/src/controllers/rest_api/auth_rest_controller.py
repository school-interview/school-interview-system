import os
from fastapi import Depends, HTTPException, Query, Request, Response
from fastapi.security import OAuth2AuthorizationCodeBearer
from fastapi.responses import HTMLResponse, RedirectResponse
from src.controllers.rest_api.auth import AUTHORIZATION_URL, CLIENT_ID, CLIENT_SECRET, REDIRECT_URI, TOKEN_URL, verify_token
from src.database import session_factory
from src.models import RestApiController, ErrorResponse, IdInfo, TokenPair
from typing import Any, List
from src.usecases.auth.login import login
from sqlalchemy.orm import Session
from dotenv import load_dotenv
import httpx

load_dotenv(".env.local")
CLIENT_URL = os.getenv("CLIENT_URL")


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
        id_info = verify_token(id_token)
        login(session, id_info)
        token_pair = TokenPair(
            id_token=id_token, refresh_token=refresh_token)
        response_body = f"""
            <script type="text/javascript">
                window.opener.postMessage(
                    '{token_pair.model_dump_json()}', '{CLIENT_URL}');
                window.close();
            </script>
        """

        return Response(content=response_body, media_type="text/html")


auth_rest_api_controllers: List[RestApiController] = [
    LoginRestApiController(),
    OAuthCallbackRestApiController()


]
