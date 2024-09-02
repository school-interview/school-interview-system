import uuid
from sqlalchemy.orm import Session
from src.models import Teacher, EntityBaseModel, InterviewQuestion
from typing import List
from sqlalchemy.orm import Session


def seed_all(session: Session):
    seed_teachers(session)
    seed_questions(session)


def seed_teachers(session: Session):
    row_count = get_number_of_rows(session, Teacher)
    if row_count > 0:
        return
    teachers: List[Teacher] = [
        Teacher(
            id=uuid.uuid4(),
            name="Teacher 1",
            description="1人目の先生です。"
        )
    ]
    session.add_all(teachers)
    session.commit()


def seed_questions(session: Session):
    row_count = get_number_of_rows(session, InterviewQuestion)
    if row_count > 0:
        return
    questions: List[InterviewQuestion] = [
        InterviewQuestion(
            id=uuid.uuid4(),
            question="現状の取得単位数は？",
            order=1,
        ),
        InterviewQuestion(
            id=uuid.uuid4(),
            question="今学期の取得予定単位数は？",
            order=2,
        ),
        InterviewQuestion(
            id=uuid.uuid4(),
            question="累積GPAは?",
            order=3,
        ),
        InterviewQuestion(
            id=uuid.uuid4(),
            question="出席率は？",
            order=4
        ),
        InterviewQuestion(
            id=uuid.uuid4(),
            question="学校生活で困っていることは？",
            order=5
        ),
        InterviewQuestion(
            id=uuid.uuid4(),
            question="教員との面談を希望しますか？",
            order=6
        )
    ]
    session.add_all(questions)
    session.commit()


def get_number_of_rows(session: Session, model: EntityBaseModel) -> int:
    return session.query(model).count()
