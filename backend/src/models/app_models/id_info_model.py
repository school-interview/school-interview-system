from typing import TypedDict


class IdInfo(TypedDict):
    iss: str
    azp: str
    aud: str
    sub: str
    email: str
    email_verified: bool
    at_hash: str
    name: str
    picture: str
    given_name: str
    family_name: str
    iat: int
    exp: int
