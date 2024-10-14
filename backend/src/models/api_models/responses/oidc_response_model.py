from pydantic import BaseModel


class OidcResponse(BaseModel):
    id_token: str
    refresh_token: str
