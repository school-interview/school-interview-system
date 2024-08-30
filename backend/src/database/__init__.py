from sqlalchemy import create_engine
from sqlalchemy.orm import Session
from models import BaseModel

from models import User


async def connect_db():
    engine = create_engine(
        "postgresql://user:postgres@db:5432/school-interview", echo=True)
    connection = engine.connect()
    session = Session(engine)
    BaseModel.metadata.create_all(engine)
    session.commit()
    return engine, connection, session
