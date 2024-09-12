from typing import List, Optional
import uuid
from fastapi import Depends
from src.models import RestApiController, InterviewSessionRequest, SpeakToTeacherRequest, InterviewSession, TeacherResponse
from src.usecases import start_interview, speak_to_teacher, finish_interview
from src.database import session_factory
from fastapi.encoders import jsonable_encoder
from fastapi.responses import JSONResponse


class StartInterviewSessionRestApiController(RestApiController):
    method = "POST"
    path = "/interview"

    async def controller(self, data: InterviewSessionRequest, db_session=Depends(session_factory)):
        user_id = uuid.UUID(data.user_id)
        teacher_id = uuid.UUID(data.teacher_id)
        interview_session = start_interview(db_session, user_id, teacher_id)

        return {
            "id": interview_session.id,
            "user_id": interview_session.user_id,
            "teacher_id": interview_session.teacher_id,
            "start_at": interview_session.start_at,
            "progress": interview_session.progress,
            "done": interview_session.done
        }


class SpeakToTeacherRestApiController(RestApiController):
    method = "POST"
    path = "/interview/{interview_session_id}"

    async def controller(self, data: SpeakToTeacherRequest, interview_session_id: str, db_session=Depends(session_factory)):
        interview_session_id: uuid.UUID = uuid.UUID(interview_session_id)
        message = data.message
        interview_query = db_session.query(InterviewSession).where(
            InterviewSession.id == interview_session_id)
        interview_session: Optional[InterviewSession] = db_session.execute(
            interview_query).first()[0]
        if not interview_session:
            raise Exception("Interview session not found.")
        print("メッセージ内容", type(message), message)
        message_from_teacher: TeacherResponse = speak_to_teacher(
            db_session, interview_session, message)
        return message_from_teacher


class FinishInterviewSessionRestApiController(RestApiController):
    method = "DELETE"
    path = "/interview/{interview_session_id}"

    async def controller(self, interview_session_id: str, db_session=Depends(session_factory)):
        interview_session_id: uuid.UUID = uuid.UUID(interview_session_id)
        interview_query = db_session.query(InterviewSession).where(
            InterviewSession.id == interview_session_id)
        interview_session: Optional[InterviewSession] = db_session.execute(
            interview_query).first()[0]
        if not interview_session:
            raise Exception("Interview session not found.")
        finish_interview(db_session, interview_session)
        return None


interview_rest_api_controllers: List[RestApiController] = [StartInterviewSessionRestApiController(
), SpeakToTeacherRestApiController(), FinishInterviewSessionRestApiController()]
