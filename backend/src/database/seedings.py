import uuid
from sqlalchemy.orm import Session
from src.models import TeacherModel, EntityBaseModel, InterviewQuestionModel
from typing import List
from sqlalchemy.orm import Session


def seed_all(session: Session):
    seed_teachers(session)
    seed_questions(session)


def seed_teachers(session: Session):
    row_count = get_number_of_rows(session, TeacherModel)
    if row_count > 0:
        return
    teachers: List[TeacherModel] = [
        TeacherModel(
            id=uuid.uuid4(),
            name="Teacher 1",
            description="1人目の先生です。"
        )
    ]
    session.add_all(teachers)
    session.commit()


def seed_questions(session: Session):
    row_count = get_number_of_rows(session, InterviewQuestionModel)
    if row_count > 0:
        return
    questions: List[InterviewQuestionModel] = [
        InterviewQuestionModel(
            id=uuid.uuid4(),
            question="現状の取得単位数は？",
            prompt="Please extract the number of credits from the following text. Extract only the numerical value.",
            order=1,
        ),
        InterviewQuestionModel(
            id=uuid.uuid4(),
            question="今学期の取得予定単位数は？",
            prompt="Please extract the number of credits planned to be taken this semester from the following text. Extract only the numerical value.",
            order=2,
        ),
        InterviewQuestionModel(
            id=uuid.uuid4(),
            question="累積GPAは?",
            prompt="Please extract the cumulative GPA from the following text. Extract only the numerical value",
            order=3,
        ),
        InterviewQuestionModel(
            id=uuid.uuid4(),
            question="出席率は？",
            prompt="Please extract the attendance rate from the following text. Extract only the numerical value.",
            order=4
        ),
        InterviewQuestionModel(
            id=uuid.uuid4(),
            question="学校生活で困っていることは？",
            prompt="“Please extract the factors causing difficulties in school life from the following text. If no difficulties are observed, input 'None'.",
            order=5
        ),
        InterviewQuestionModel(
            id=uuid.uuid4(),
            question="教員との面談を希望しますか？",
            prompt="Please extract whether a meeting with the teacher is requested from the following text. Extract as `True` or `False`.",
            order=6
        )
    ]
    session.add_all(questions)
    session.commit()


def get_number_of_rows(session: Session, model: EntityBaseModel) -> int:
    return session.query(model).count()
