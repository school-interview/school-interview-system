from typing import Optional


class ErrorResponse(Exception):
    def __init__(self, status_code: int, type: str, title: str, detail: Optional[str]):
        self.status_code = status_code
        self.type = type
        self.title = title
        self.detail = detail
