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
            prompt="次の文章から単位数を抽出してください。数値のみを抽出してください",
            order=1,
        ),
        InterviewQuestionModel(
            id=uuid.uuid4(),
            question="今学期の取得予定単位数は？",
            prompt="次の文章から今学期取得予定の単位数を抽出してください。数値のみを抽出してください",
            order=2,
        ),
        InterviewQuestionModel(
            id=uuid.uuid4(),
            question="累積GPAは?",
            prompt="次の文章から累計GPAを抽出してください。数値のみを抽出してください",
            order=3,
        ),
        InterviewQuestionModel(
            id=uuid.uuid4(),
            question="出席率は？",
            prompt="次の文章から出席率を抽出してください。数値のみを抽出してください",
            order=4
        ),
        InterviewQuestionModel(
            id=uuid.uuid4(),
            question="学校生活で困っていることは？",
            prompt="次の文章から学校生活で困っている要因を抽出してください。",
            order=5
        ),
        InterviewQuestionModel(
            id=uuid.uuid4(),
            question="教員との面談を希望しますか？",
            prompt="次の文章から教員との面談希望をしているかどうかを抽出してください。trueかfalseで抽出してください。",
            order=6
        )
    ]
    session.add_all(questions)
    session.commit()


def get_number_of_rows(session: Session, model: EntityBaseModel) -> int:
    return session.query(model).count()
