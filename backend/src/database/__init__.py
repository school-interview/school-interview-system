from sqlalchemy import create_engine


async def connect_db():
    engine = create_engine(
        "postgresql://user:postgres@db:5432/school-interview")
    async with engine.connect() as conn:
        return conn
