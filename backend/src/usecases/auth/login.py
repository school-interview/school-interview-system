import uuid
from sqlalchemy import select
from src.crud import UsersCrud, StudentsCrud, AdminCrud
from src.models import IdInfo, User, UserModel, UserUpdate, NotSchoolMemberException, StudentModel, AdminModel
from sqlalchemy.orm import Session
from typing import Tuple
import re


def login(db_session: Session, id_info: IdInfo) -> UserModel:
    """
    This function is used to login a user.

    `is_admin` flag is set to false temporarily.(I haven't implemented the admin feature yet)
    """
    user_crud = UsersCrud(UserModel)
    user_model = user_crud.get_by_email(db_session, id_info["email"])
    if not _is_school_member_email(id_info["email"]):
        raise NotSchoolMemberException(
            "You need to login with your school Google account.")
    if user_model:
        user_update = UserUpdate(
            name=id_info['name'],
            email=id_info['email'],
            is_admin=not _is_student_email(id_info['email'])
        )
        user_model = user_crud.update(
            db_session, db_obj=user_model, obj_in=user_update)
    else:
        user_model = UserModel(
            id=uuid.uuid4(),
            name=id_info['name'],
            email=id_info['email'],
            is_admin=not _is_student_email(id_info['email'])
        )
        user_crud.create(db_session, obj_in=user_model)
        if user_model.is_admin:
            admins_crud = AdminCrud(AdminModel)
            admin_model = AdminModel(
                id=uuid.uuid4(),
                user_id=user_model.id
            )
            admins_crud.crate(db_session, obj_in=admin_model)
        else:
            students_crud = StudentsCrud(StudentModel)
            studnet_model = StudentModel(
                id=uuid.uuid4(),
                user_id=user_model.id,
                student_id=None,
                department=None,
                semester=None
            )
            students_crud.create(db_session, obj_in=studnet_model)
    return user_model


def _is_school_member_email(email: str):
    """
        Return whether the email is a member of the school.
        Args:
            email: str
        Returns:

        Raises:

    """
    kit_email_regex = r"^[A-Za-z0-9]{1}[A-Za-z0-9_.-]*@{1}[A-Za-z0-9_.-]{1,}\.kanazawa-it.ac.jp$"
    matcher = re.compile(kit_email_regex)
    return bool(matcher.match(email))


def _is_student_email(email: str):
    """
        Return whether the email is a student email.
    """
    student_email_regex = r"^[a-z]{1}[0-9]{7}@{1}[A-Za-z0-9_.-]{1,}\.kanazawa-it.ac.jp$"
    matcher = re.compile(student_email_regex)
    return bool(matcher.match(email))
