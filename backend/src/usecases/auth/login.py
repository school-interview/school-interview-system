import uuid
from sqlalchemy import select
from src.models.db_models.user_model import User
from src.models import LoginRequest
from sqlalchemy.orm import Session
from typing import Tuple


def login(session: Session, login_request: LoginRequest) -> User:
    user_query: Tuple = select(User).where(
        User.student_id == login_request.student_id)
    user = session.execute(user_query).scalars().first()
    if not user:
        user = User(
            id=uuid.uuid4(),
            student_id=login_request.student_id,
            name=login_request.name,
            department=login_request.department,
            grade=login_request.grade
        )
        session.add(user)
        session.commit()
    return user
