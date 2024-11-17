from typing import List

from fastapi import Depends
from pydantic import TypeAdapter
from sqlalchemy import UUID
from sqlalchemy.orm import Session
from src.controllers.rest_api.auth import verify_admin, verify_user
from src.database import session_factory
from src.models import RestApiController, User, UserModel, Student, StudentModel, StudentUpdate, ErrorResponse, Admin
from src.crud import StudentsCrud, UsersCrud


class UsersRestApiController(RestApiController):
    method = "GET"
    path = "/users"
    response_model = List[User]

    async def controller(self, db_session: Session = Depends(session_factory), user_model=Depends(verify_admin)):
        users_crud = UsersCrud(UserModel)
        users = [user.convert_to_dict()
                 for user in users_crud.get_multi(db_session)]
        return users


class MeRestApiController(RestApiController):
    method = "GET"
    path = "/me"
    response_model = User

    async def controller(self, db_session: Session = Depends(session_factory), user_model: UserModel = Depends(verify_user)):
        users_crud = UsersCrud(UserModel)
        model_class_mapping = {
            "AdminModel": Admin,
            "StudentModel": Student
        }
        if user_model.is_admin:
            user_model = users_crud.get_with_admin(db_session, user_model.id)
            return user_model.convert_to_pydantic(User, set(), model_class_mapping)
        else:
            user_model = users_crud.get_with_student(db_session, user_model.id)
            return user_model.convert_to_pydantic(User, set(), model_class_mapping)


class UpdateStudentRestApiController(RestApiController):
    method = "PUT"
    path = "/users/{user_id}/student"
    response_model = Student

    async def controller(self, setudent_update: StudentUpdate, user_id: str, db_session: Session = Depends(session_factory), user_model: UserModel = Depends(verify_user)):
        if user_model.id.__str__() != user_id:
            raise ErrorResponse(
                status_code=400,
                type="invalid_user_id",
                title="Invalid user id",
                detail="You can only update your own Student info."
            )
        model_class_mapping = {
            "UserModel": User,
        }
        student_crud = StudentsCrud(StudentModel)
        student_model = student_crud.get_by_user_id(db_session, user_model.id)
        student_model = student_crud.update(db_session, db_obj=student_model,
                                            obj_in=setudent_update)
        return student_model.convert_to_pydantic(Student, set(), model_class_mapping)


user_rest_api_controllers: List[RestApiController] = [
    UsersRestApiController(), MeRestApiController(), UpdateStudentRestApiController()]
