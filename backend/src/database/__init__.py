from sqlalchemy import create_engine
from sqlalchemy.orm import Session
from models import ModelBase

from models import User


async def connect_db():
    engine = create_engine(
        "postgresql://user:postgres@db:5432/school-interview", echo=True)
    connection = engine.connect()
    with Session(engine) as session:
        ModelBase.metadata.create_all(engine)
        user = User(name="dan", studentId="1119059",
                    department="情報工学科", grade=4)
        session.add(user)
        session.commit()
    return connection
