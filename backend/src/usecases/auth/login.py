import uuid
from sqlalchemy import select
from src.models import LoginRequest, UserModel
from sqlalchemy.orm import Session
from typing import Tuple


def login(session: Session, login_request: LoginRequest) -> UserModel:
    user_query: Tuple = select(UserModel).where(
        UserModel.student_id == login_request.student_id)
    user = session.execute(user_query).scalars().first()
    if not user:
        user = UserModel(
            id=uuid.uuid4(),
            student_id=login_request.student_id,
            name=login_request.name,
            department=login_request.department,
            grade=login_request.grade
        )
        session.add(user)
        session.commit()
    return user
