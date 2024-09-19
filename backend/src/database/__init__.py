from sqlalchemy import create_engine
from sqlalchemy.orm import Session, sessionmaker
from src.database.seedings import seed_all
from dotenv import load_dotenv
from os import environ
from src.models import EntityBaseModel

SessionMaker: sessionmaker = None

load_dotenv(".env")


def connect_db():
    url = environ.get("DATABASE_URL")
    print("Connecting to database: ", url)
    engine = create_engine(
        url, echo=True)
    engine.connect()
    global SessionMaker
    SessionMaker = sessionmaker(bind=engine)
    session = Session(engine)
    EntityBaseModel.metadata.create_all(engine)
    seed_all(session)
    session.close()
    return engine


def session_factory():
    session = SessionMaker()
    try:
        yield session
    finally:
        session.close()
