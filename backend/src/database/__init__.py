from sqlalchemy import create_engine
from sqlalchemy.orm import Session
from src.database.seedings import seed_all


async def connect_db():
    engine = create_engine(
        "postgresql://user:postgres@db:5432/school-interview", echo=True)
    connection = engine.connect()
    session = Session(engine)
    seed_all(session)
    return engine, connection, session
