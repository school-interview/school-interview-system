from pydantic import BaseModel


class InterviewRequest(BaseModel):
    message_from_student: str
    current_question: str
