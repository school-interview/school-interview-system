from pydantic import BaseModel


class LlmServiceInterviewRequest(BaseModel):
    message_from_student: str
    current_question: str
