import uuid
from sqlalchemy import select
from src.crud import UsersCrud
from src.models import IdInfo, User, UserModel, UserUpdate
from sqlalchemy.orm import Session
from typing import Tuple


def login(db_session: Session, id_info: IdInfo) -> UserModel:
    """
    This function is used to login a user.

    `is_admin` flag is set to false temporarily.(I haven't implemented the admin feature yet)
    """
    user_crud = UsersCrud(UserModel)
    user = user_crud.get_by_email(db_session, id_info["email"])
    if user:
        user_update = UserUpdate(
            name=id_info['name'],
            email=id_info['email'],
        )
        user_crud.update(db_session, db_obj=user, obj_in=user_update)
    else:
        user = UserModel(
            id=uuid.uuid4(),
            name=id_info['name'],
            email=id_info['email'],
            is_admin=False
        )
        user_crud.create(db_session, obj_in=user)
    return user
