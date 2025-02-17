from typing import List, Optional
import uuid
from fastapi import Depends, HTTPException
from pydantic import TypeAdapter
from src.controllers.rest_api.auth import verify_user, verify_admin
from src.models import User, InterviewQuestion, RestApiController, InterviewSessionRequest, SpeakToTeacherRequest, InterviewSession, InterviewSessionModel, TeacherResponse, Teacher, StartInterviewResponse, InterviewQuestionModel, InterviewAlreadyStartedException, ErrorResponse, TeacherModel, UserModel, InterviewRecordModel, InterviewAnalytics, InterviewAnalyticsModel, InterviewReport, InterviewReportsResponse, InterviewSessionNotFoundException
from src.usecases import start_interview, speak_to_teacher, finish_interview, analyze_interview, collect_interview_reports
from src.database import session_factory
from src.crud import InterviewSessionsCrud
from sqlalchemy.orm import Session


class StartInterviewSessionRestApiController(RestApiController):
    method = "POST"
    path = "/interview"
    response_model = StartInterviewResponse

    async def controller(self, data: InterviewSessionRequest, db_session: Session = Depends(session_factory), user_model=Depends(verify_user)):
        user_id = uuid.UUID(data.user_id)
        teacher_id = uuid.UUID(data.teacher_id)
        if user_model.id != user_id:
            raise ErrorResponse(
                status_code=403,
                type="forbidden",
                title="Forbidden",
                detail="You are not allowed to start an interview for another user."
            )
        try:
            interview_session_model: Optional[InterviewSessionModel] = start_interview(
                db_session,
                user_id,
                teacher_id
            )
            if interview_session_model is None:
                raise InterviewSessionNotFoundException(
                    "Coudn't load interview session.")

        except InterviewAlreadyStartedException:
            raise ErrorResponse(
                status_code=400,
                type="interview_already_started",
                title="Interview already started.",
                detail="You can only start one interview at a time. Please finish the current interview first."
            )
        except InterviewSessionNotFoundException:
            raise ErrorResponse(
                status_code=500,
                type="interview_session_not_found",
                title="Interview session not found.",
                detail="Couldn't load interview session."
            )
        model_class_mapping = {
            "TeacherModel": Teacher,
            "UserModel": User,
            "InterviewQuestionModel": InterviewQuestion
        }
        interview_session = interview_session_model.convert_to_pydantic(
            InterviewSession, obj_history=set(), model_class_mapping=model_class_mapping)

        response = StartInterviewResponse(
            interview_session=interview_session,
            message_from_teacher=interview_session_model.current_question.question
        )
        return response


class SpeakToTeacherRestApiController(RestApiController):
    method = "POST"
    path = "/interview/{interview_session_id}"
    response_model = TeacherResponse

    async def controller(self, data: SpeakToTeacherRequest, interview_session_id: str, db_session=Depends(session_factory), user_model=Depends(verify_user)):
        session_id: uuid.UUID = uuid.UUID(interview_session_id)
        message = data.message_from_student
        interview_sessions_crud = InterviewSessionsCrud(InterviewSessionModel)
        interview_session_model = interview_sessions_crud.get_with_curernt_question(
            db_session, session_id)
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
        model_class_mapping = {
            "TeacherModel": Teacher,
            "UserModel": User
        }
        teacher_response = TeacherResponse(
            message_from_teacher=message_from_teacher,
            interview_session=interview_session_model.convert_to_pydantic(
                InterviewSession, obj_history=set(), model_class_mapping=model_class_mapping)
        )

        return teacher_response


class FinishInterviewSessionRestApiController(RestApiController):
    method = "DELETE"
    path = "/interview/{interview_session_id}"
    response_model = None

    async def controller(self, interview_session_id: str, db_session=Depends(session_factory), user_model=Depends(verify_user)):
        session_id: uuid.UUID = uuid.UUID(interview_session_id)
        interview_query = db_session.query(InterviewSession).where(
            InterviewSession.id == session_id)
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

    async def controller(self, interview_session_id: str, db_session=Depends(session_factory), user_model=Depends(verify_user)):
        session_id: uuid.UUID = uuid.UUID(interview_session_id)
        interview_query = db_session.query(InterviewSessionModel).where(
            InterviewSessionModel.id == session_id)
        query_result: Optional[InterviewSessionModel] = db_session.execute(
            interview_query).first()
        interview_session: InterviewSessionModel = query_result[0] if query_result else None
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
        interview_analytics_model: InterviewAnalyticsModel = analyze_interview(
            db_session, interview_session)
        interview_analytics_dict = interview_analytics_model.convert_to_dict()
        interview_analytics = TypeAdapter(InterviewAnalytics).validate_python(
            interview_analytics_dict)
        return interview_analytics


class InterviewReportsRestApiController(RestApiController):
    method = "GET"
    path = "/interview-reports"
    response_model = InterviewReportsResponse

    async def controller(self, db_session=Depends(session_factory), admin=Depends(verify_admin)):
        reports: List[InterviewReport] = collect_interview_reports(db_session)
        return InterviewReportsResponse(reports=reports)


interview_rest_api_controllers: List[RestApiController] = [StartInterviewSessionRestApiController(
), SpeakToTeacherRestApiController(), FinishInterviewSessionRestApiController(), AnalyticsInterviewRestApiController(), InterviewReportsRestApiController()]
