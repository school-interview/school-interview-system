

from typing import List
from sqlalchemy.orm import Session
from fastapi import Depends
from pydantic import TypeAdapter
from src.database import session_factory
from src.models import RestApiController, Teacher, TeacherModel, TeachersListResponse
from src.crud import TeachersCrud


class TeachersRestApiController(RestApiController):
    method = "GET"
    path = "/teachers"
    response_model = TeachersListResponse

    async def controller(self, db_session: Session = Depends(session_factory)):
        teachers_crud = TeachersCrud(TeacherModel)
        teachers = [t.convert_to_dict()
                    for t in teachers_crud.get_multi(db_session)]
        response = TeachersListResponse(teachers=teachers, count=len(teachers))
        return response


teacher_rest_api_controllers: List[RestApiController] = [
    TeachersRestApiController()]
