

from typing import List

from fastapi import Depends
from pydantic import TypeAdapter
from pytest import Session
from src.database import session_factory
from src.models import RestApiController, Teacher, TeacherModel, TeacherResponse


class TeachersRestApiController(RestApiController):
    method = "GET"
    path = "/teachers"
    response_model = TeacherResponse

    async def controller(self, db_session: Session = Depends(session_factory)):
        teacher_query = db_session.query(TeacherModel)
        teachers = [TypeAdapter(Teacher).validate_python(
            teacher[0].__dict__) for teacher in db_session.execute(teacher_query).all()]
        response = TeacherResponse(teachers=teachers, count=len(teachers))
        return response


teacher_rest_api_controllers: List[RestApiController] = [
    TeachersRestApiController()]
