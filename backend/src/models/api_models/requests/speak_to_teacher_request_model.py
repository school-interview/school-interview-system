from pydantic import BaseModel


class SpeakToTeacherRequest(BaseModel):
    message_from_student: str
