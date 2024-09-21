from typing import List, Optional
import uuid
from fastapi import Depends, HTTPException
from pydantic import TypeAdapter
from src.models import User, RestApiController, InterviewSessionRequest, SpeakToTeacherRequest, InterviewSession, InterviewSessionModel, TeacherResponse, Teacher, StartInterviewResponse, InterviewQuestionModel, InterviewAlreadyStartedException, ErrorResponse, TeacherModel, UserModel, InterviewRecordModel, InterviewAnalytics
from src.usecases import start_interview, speak_to_teacher, finish_interview, analyze_interview
from src.database import session_factory
from sqlalchemy.orm import Session


class TeachersRestApiController(RestApiController):
    method = "GET"
    path = "/teachers"
    response_model = List[Teacher]

    async def controller(self, db_session: Session = Depends(session_factory)):
        teacher_query = db_session.query(TeacherModel)
        teachers = [TypeAdapter(Teacher).validate_python(
            teacher[0].__dict__) for teacher in db_session.execute(teacher_query).all()]
        return teachers


class UsersRestApiController(RestApiController):
    method = "GET"
    path = "/users"
    response_model = List[User]

    async def controller(self, db_session: Session = Depends(session_factory)):
        user_query = db_session.query(UserModel)
        users = [TypeAdapter(User).validate_python(
            user[0].__dict__) for user in db_session.execute(user_query).all()]
        return users


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
        interview_session = TypeAdapter(
            InterviewSession).validate_python(interview_session_model.__dict__)
        interview_session.teacher = TypeAdapter(Teacher).validate_python(
            interview_session_model.teacher.__dict__)
        interview_session.user = TypeAdapter(User).validate_python(
            interview_session_model.user.__dict__)
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
        query_result: Optional[InterviewSessionModel] = db_session.execute(
            interview_query).first()
        interview_session_model = query_result[0] if query_result else None
        if not interview_session_model:
            raise ErrorResponse(
                status_code=404,
                type="interview_not_found",
                title="Interview not found.",
                detail="The interview session does not exist. Please start a new interview."
            )
        elif interview_session_model.done:
            raise ErrorResponse(
                status_code=400,
                type="interview_already_done",
                title="Interview already done.",
                detail="The interview has already been done. Please start a new interview."
            )
        message_from_teacher = speak_to_teacher(
            db_session, interview_session_model, message)

        teacher_response = TeacherResponse(
            message_from_teacher=message_from_teacher,
            interview_session=TypeAdapter(
                InterviewSession).validate_python(interview_session_model.__dict__)
        )

        return teacher_response


class FinishInterviewSessionRestApiController(RestApiController):
    method = "DELETE"
    path = "/interview/{interview_session_id}"
    response_model = None

    async def controller(self, interview_session_id: str, db_session=Depends(session_factory)):
        interview_session_id: uuid.UUID = uuid.UUID(interview_session_id)
        interview_query = db_session.query(InterviewSession).where(
            InterviewSession.id == interview_session_id)
        query_result: Optional[InterviewSession] = db_session.execute(
            interview_query).first()
        interview_session = query_result[0] if query_result else None
        if not interview_session:
            raise ErrorResponse(
                status_code=404,
                type="interview_not_found",
                title="Interview not found.",
                detail="The interview session does not exist. Please start a new interview."
            )
        finish_interview(db_session, interview_session)
        return None


class AnalyticsInterviewRestApiController(RestApiController):
    method = "GET"
    path = "/interview/{interview_session_id}/analytics"
    response_model = InterviewAnalytics

    async def controller(self, interview_session_id: str, db_session=Depends(session_factory)):
        interview_session_id: uuid.UUID = uuid.UUID(interview_session_id)
        interview_query = db_session.query(InterviewSession).where(
            InterviewSession.id == interview_session_id)
        query_result: Optional[InterviewSession] = db_session.execute(
            interview_query).first()
        interview_session: InterviewSession = query_result[0] if query_result else None
        if not interview_session:
            raise ErrorResponse(
                status_code=404,
                type="interview_not_found",
                title="Interview not found.",
                detail="The interview session does not exist. Please start a new interview."
            )
        if not interview_session.done:
            raise ErrorResponse(
                status_code=400,
                type="interview_not_done",
                title="Interview not done.",
                detail="The interview session is not done yet. Please finish the interview first."
            )
        interview_record_query = db_session.query(InterviewRecordModel).where(
            InterviewRecordModel.session_id == interview_session_id)
        query_result = db_session.execute(interview_record_query).first()
        interview_record = query_result[0] if query_result else None
        interview_analytics_model = analyze_interview(
            db_session, interview_record)
        interview_analytics = TypeAdapter(InterviewAnalytics).validate_python(
            interview_analytics_model.__dict__)
        return interview_analytics


interview_rest_api_controllers: List[RestApiController] = [TeachersRestApiController(), UsersRestApiController(), StartInterviewSessionRestApiController(
), SpeakToTeacherRestApiController(), FinishInterviewSessionRestApiController(), AnalyticsInterviewRestApiController()]
