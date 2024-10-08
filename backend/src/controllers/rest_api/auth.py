import os
from dotenv import load_dotenv
from fastapi import Request
from fastapi.security import OAuth2AuthorizationCodeBearer
from google.oauth2 import id_token
from google.auth.transport import requests
from src.models import ErrorResponse, IdInfo


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

        # TODO: RefreshTokenを使ってIDトークンの再取得を行う
        # ↓ 参考になるかも
        # https://developers.google.com/identity/protocols/oauth2/web-server#python_8
        id_info: IdInfo = id_token.verify_oauth2_token(
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


async def verify_user(request: Request):
    """ 
        ユーザーの認証を行う。 Depends()で使用することを想定している。



                """
