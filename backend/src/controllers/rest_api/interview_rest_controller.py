from typing import List, Optional
import uuid
from fastapi import Depends, HTTPException
from src.models import RestApiController, InterviewSessionRequest, SpeakToTeacherRequest, InterviewSession, InterviewSessionModel, TeacherResponse, Teacher, StartInterviewResponse, InterviewQuestionModel, InterviewAlreadyStartedException, ErrorResponse
from src.usecases import start_interview, speak_to_teacher, finish_interview
from src.database import session_factory


class StartInterviewSessionRestApiController(RestApiController):
    method = "POST"
    path = "/interview"
    response_model = StartInterviewResponse

    async def controller(self, data: InterviewSessionRequest, db_session=Depends(session_factory)):
        user_id = uuid.UUID(data.user_id)
        teacher_id = uuid.UUID(data.teacher_id)
        try:
            interview_session_model = start_interview(
                db_session, user_id, teacher_id)
        except InterviewAlreadyStartedException:
            raise ErrorResponse(
                status_code=400,
                type="interview_already_started",
                title="Interview already started.",
                detail="You can only start one interview at a time. Please finish the current interview first."
            )

        interview_session = InterviewSession(
            id=interview_session_model.id,
            user_id=interview_session_model.user_id,
            teacher_id=interview_session_model.teacher_id,
            teacher=Teacher(
                id=interview_session_model.teacher.id,
                name=interview_session_model.teacher.name,
                description=interview_session_model.teacher.description,
            ),
            start_at=interview_session_model.start_at,
            progress=interview_session_model.progress,
            done=interview_session_model.done
        )
        question_query = db_session.query(InterviewQuestionModel).where(
            InterviewQuestionModel.order == 1)
        first_question: Optional[InterviewQuestionModel] = db_session.execute(
            question_query).first()[0]
        response = StartInterviewResponse(
            interview_session=interview_session,
            message_from_teacher=first_question.question
        )
        return response


class SpeakToTeacherRestApiController(RestApiController):
    method = "POST"
    path = "/interview/{interview_session_id}"
    response_model = TeacherResponse

    async def controller(self, data: SpeakToTeacherRequest, interview_session_id: str, db_session=Depends(session_factory)):
        interview_session_id: uuid.UUID = uuid.UUID(interview_session_id)
        message = data.message_from_student
        interview_query = db_session.query(InterviewSessionModel).where(
            InterviewSessionModel.id == interview_session_id)
        interview_session: Optional[InterviewSessionModel] = db_session.execute(
            interview_query).first()[0]
        if not interview_session:
            raise ErrorResponse(
                status_code=404,
                type="interview_not_found",
                title="Interview not found.",
                detail="The interview session does not exist. Please start a new interview."
            )
        elif interview_session.done:
            raise ErrorResponse(
                status_code=400,
                type="interview_already_done",
                title="Interview already done.",
                detail="The interview has already been done. Please start a new interview."
            )
        message_from_teacher: TeacherResponse = speak_to_teacher(
            db_session, interview_session, message)
        return message_from_teacher


class FinishInterviewSessionRestApiController(RestApiController):
    method = "DELETE"
    path = "/interview/{interview_session_id}"
    response_model = None

    async def controller(self, interview_session_id: str, db_session=Depends(session_factory)):
        interview_session_id: uuid.UUID = uuid.UUID(interview_session_id)
        interview_query = db_session.query(InterviewSession).where(
            InterviewSession.id == interview_session_id)
        interview_session: Optional[InterviewSession] = db_session.execute(
            interview_query).first()[0]
        if not interview_session:
            raise ErrorResponse(
                status_code=404,
                type="interview_not_found",
                title="Interview not found.",
                detail="The interview session does not exist. Please start a new interview."
            )
        finish_interview(db_session, interview_session)
        return None


interview_rest_api_controllers: List[RestApiController] = [StartInterviewSessionRestApiController(
), SpeakToTeacherRestApiController(), FinishInterviewSessionRestApiController()]
