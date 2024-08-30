from sqlalchemy import create_engine
from sqlalchemy.orm import Session, sessionmaker
from src.database.seedings import seed_all

SessionMaker: sessionmaker = None


def connect_db():
    engine = create_engine(
        "postgresql://user:postgres@db:5432/school-interview", echo=True)
    engine.connect()
    global SessionMaker
    SessionMaker = sessionmaker(bind=engine)
    session = Session(engine)
    seed_all(session)
    session.close()
    return engine


def session_factory():
    session = SessionMaker()
    try:
        yield session
    finally:
        session.close()


connect_db()
