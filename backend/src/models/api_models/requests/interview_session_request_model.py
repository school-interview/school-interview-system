from pydantic import BaseModel


class InterviewSessionRequest(BaseModel):
    user_id: str
    teacher_id: str
