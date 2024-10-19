import os
from dotenv import load_dotenv
from fastapi import Depends, Request
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer, OAuth2AuthorizationCodeBearer
from google.oauth2 import id_token
from google.auth.transport import requests
from src.database import session_factory
from src.crud import UsersCrud
from src.models import ErrorResponse, IdInfo, UserModel
from sqlalchemy.orm import Session


load_dotenv(".env.local")

CLIENT_ID = os.getenv("CLIENT_ID")
CLIENT_SECRET = os.getenv("CLIENT_SECRET")
REDIRECT_URI = os.getenv("REDIRECT_URI")
CLINET_URL = os.getenv("CLIENT_URL")
AUTHORIZATION_URL = "https://accounts.google.com/o/oauth2/v2/auth"
TOKEN_URL = "https://oauth2.googleapis.com/token"


oauth2_scheme = OAuth2AuthorizationCodeBearer(
    authorizationUrl=AUTHORIZATION_URL,
    tokenUrl=TOKEN_URL
)


def verify_token(jwt: str):
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


def verify_user(request: Request, db_session: Session = Depends(session_factory), authorization: HTTPAuthorizationCredentials = Depends(HTTPBearer())):
    """ 
        REST API呼び出し時のユーザーの認証を行う。 Depends()で使用することを想定している。

        Args:
            request (Request): FastAPIのRequestオブジェクト(自動で渡されるはず)
            authorization (HTTPAuthorizationCredentials): FastAPIのHTTPAuthorizationCredentialsオブジェクト。Bearerトークンを取得するために使用する。

        Returns:
            UserModel: 認証されたユーザーのモデル

        Raises:
            ErrorResponse: 認証が失敗した場合に発生する例外
    """
    id_token = authorization.credentials
    if not id_token:
        raise ErrorResponse(
            status_code=401,
            type="unauthorized",
            title="Unauthorized",
            detail="The user is not authenticated."
        )
    id_info = verify_token(id_token)
    user_curd = UsersCrud(UserModel)
    user = user_curd.get_by_email(db_session, id_info["email"])
    return user
