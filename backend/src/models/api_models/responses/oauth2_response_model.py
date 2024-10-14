from pydantic import BaseModel


class OAuth2Response(BaseModel):
    id_token: str
    refresh_token: str
