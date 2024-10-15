from pydantic import BaseModel


class TokenPair(BaseModel):
    id_token: str
    refresh_token: str
