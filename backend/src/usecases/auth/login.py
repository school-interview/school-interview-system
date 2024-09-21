import uuid
from sqlalchemy import select
from src.models import LoginRequest, UserModel
from sqlalchemy.orm import Session
from typing import Tuple


def login(db_session: Session, login_request: LoginRequest) -> UserModel:
    user_query: Tuple = select(UserModel).where(
        UserModel.student_id == login_request.student_id)
    query_result = db_session.execute(user_query).scalars().first()
    user: UserModel = query_result[0] if query_result else None
    if user:
        user.name = login_request.name
        user.department = login_request.department
        user.semester = login_request.semester
        db_session.commit()
    else:
        user = UserModel(
            id=uuid.uuid4(),
            student_id=login_request.student_id,
            name=login_request.name,
            department=login_request.department,
            grade=login_request.grade
        )
        db_session.add(user)
        db_session.commit()
    return user
