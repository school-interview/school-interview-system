from pydantic import BaseModel


class LoginRequest(BaseModel):
    student_id: str
    name: str
    department: str
    semester: int
