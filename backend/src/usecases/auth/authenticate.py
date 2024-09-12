from sqlalchemy.orm.session import Session
from src.models import UserModel


def authenticate(session: Session, user_id: str) -> UserModel:
    query = session.query(UserModel).where(UserModel.id == user_id)
    user = session.execute(query).scalars().first()
    if not user:
        raise Exception("User not found")
    return user
