import uuid
from sqlalchemy import select
from src.crud import UserCrud
from src.models import IdInfo, UserModel, UserUpdate
from sqlalchemy.orm import Session
from typing import Tuple


def login(db_session: Session, id_info: IdInfo) -> UserModel:
    """
    This function is used to login a user.

    `is_admin` flag is set to false temporarily.(I haven't implemented the admin feature yet)
    """
    user_crud = UserCrud(UserModel)
    user = user_crud.get_by_emmail(db_session, id_info["email"])
    if user:
        user_update = UserUpdate(
            name=id_info['name'],
            email=id_info['email'],
            is_admin=False
        )
        user_crud.update(db_session, db_obj=UserModel, obj_in=user_update)
    else:
        user = UserModel(
            id=uuid.uuid4(),
            name=id_info['name'],
            email=id_info['email'],
            is_admin=False
        )
        user_crud.create(db_session, obj_in=user)
    return user
