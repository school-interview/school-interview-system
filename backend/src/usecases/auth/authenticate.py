from sqlalchemy.orm.session import Session
from src.models.db_models.user_model import User


def authenticate(session: Session, user_id: str):
    query = session.query(User).where(User.id == user_id)
    user = session.execute(query).scalars().first()
    if not user:
        raise Exception("User not found")
    return user
