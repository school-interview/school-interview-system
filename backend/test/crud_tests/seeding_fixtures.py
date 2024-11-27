import pytest
from typing import List
import uuid
from mock_alchemy.mocking import UnifiedAlchemyMagicMock
from sqlalchemy import create_engine, text
from src.models import UserModel, StudentModel, Student, User, InterviewSessionModel, TeacherModel, EntityBaseModel, InterviewQuestionModel, InterviewQuestionGroupModel
from src.crud import UsersCrud, StudentsCrud, InterviewSessionsCrud, TeachersCrud
from sqlalchemy.orm import Session, sessionmaker
import random
from datetime import datetime

users_crud = UsersCrud(UserModel)
students_crud = StudentsCrud(StudentModel)
interview_sessions_crud = InterviewSessionsCrud(InterviewSessionModel)
teachers_crud = TeachersCrud(TeacherModel)


@pytest.fixture(scope="module")
def db_session():
    engine = create_engine('sqlite:///:memory:', echo=True)
    SessionMaker = sessionmaker(bind=engine)
    db_session = SessionMaker()
    connection = engine.connect()
    query_for_foreign_key = text("PRAGMA foreign_keys = ON;")
    connection.execute(query_for_foreign_key)
    EntityBaseModel.metadata.create_all(engine)
    teachers = seed_teachers(db_session)
    users = seed_users(db_session)
    question_groups = seed_question_groups(db_session)
    questions = seed_questions(db_session, question_groups)
    seed_interview_sessions(
        db_session, users, teachers[0], questions)
    yield db_session
    print("finalizing... DB connection")
    db_session.close()


def seed_teachers(db_session: Session):
    teacher_model = TeacherModel(
        id=uuid.uuid4(),
        name="Teacher 1",
        description="1人目の先生です。"
    )
    teachers_crud.create(db_session=db_session, obj_in=teacher_model)
    return [teacher_model]


def seed_users(db_session: Session):
    users = [
        create_student_user(db_session, 2),
        create_student_user(db_session, 2),
        create_student_user(db_session, 2),
    ]
    return users


def seed_interview_sessions(db_session: Session, users: List[UserModel], teacher: TeacherModel, questions: List[InterviewQuestionModel]):
    first_question = questions[0]
    for user in users:
        interview_session = InterviewSessionModel(
            id=uuid.uuid4(),
            user_id=user.id,
            teacher_id=teacher.id,
            start_at=datetime.now(),
            current_question_id=first_question.id,
            done=False
        )
        interview_sessions_crud.create(db_session=db_session,
                                       obj_in=interview_session)
    return interview_sessions_crud.get_multi(db_session)


def seed_question_groups(session: Session):
    groups: List[InterviewQuestionGroupModel] = [
        InterviewQuestionGroupModel(
            id=uuid.uuid4(),
            group_name="現状の取得単位数に関する質問",
            order=1,
            questions=[]
        ),
        InterviewQuestionGroupModel(
            id=uuid.uuid4(),
            group_name="今学期の取得予定単位数に関する質問",
            order=2,
            questions=[]
        ),
        InterviewQuestionGroupModel(
            id=uuid.uuid4(),
            group_name="累積GPAに関する質問",
            order=3,
            questions=[]
        ),
        InterviewQuestionGroupModel(
            id=uuid.uuid4(),
            group_name="出席率に関する質問",
            order=4,
            questions=[]
        ),
        InterviewQuestionGroupModel(
            id=uuid.uuid4(),
            group_name="学校生活で困っていることに関する質問",
            order=5,
            questions=[]
        ),
        InterviewQuestionGroupModel(
            id=uuid.uuid4(),
            group_name="教員との面談に関する質問",
            order=6,
            questions=[]
        )
    ]
    session.add_all(groups)
    session.commit()
    return groups


def seed_questions(session: Session, question_groups: List[InterviewQuestionGroupModel]):
    questions: List[InterviewQuestionModel] = []
    first_group_id = question_groups[0].id
    questions.append(
        InterviewQuestionModel(
            id=uuid.uuid4(),
            group_id=first_group_id,
            question="現状の取得単位数は？",
            order=1,
            prompt="Please extract the number of credits from the following text. Extract only the numerical value.",
            condition_target_operand_data_type="int",
            condition_left_operand=None,
            condition_left_operator=None,
            condition_right_operand=None,
            condition_right_operator=None,
            description="前学期分までの取得単位数を答えてください。（例：私は〇〇単位取得しました。）",
            extraction_data_type="int"
        ),
    )
    second_group_id = question_groups[1].id
    questions.append(
        InterviewQuestionModel(
            id=uuid.uuid4(),
            group_id=second_group_id,
            question="今学期の取得予定単位数は？",
            order=1,
            prompt="Please extract the number of credits planned to be taken this semester from the following text. Extract only the numerical value.",
            condition_target_operand_data_type="int",
            condition_left_operand=None,
            condition_left_operator=None,
            condition_right_operand=None,
            condition_right_operator=None,
            description="今学期の取得予定単位数を答えてください。（例：私は〇〇単位取得予定です。）",
            extraction_data_type="int"
        )
    )
    third_group_id = question_groups[2].id
    questions.append(
        InterviewQuestionModel(
            id=uuid.uuid4(),
            group_id=third_group_id,
            question="累積GPAは?",
            order=1,
            prompt="Please extract the number of credits planned to be taken this semester from the following text. Extract only the numerical value.",
            condition_target_operand_data_type="float",
            condition_left_operand=None,
            condition_left_operator=None,
            condition_right_operand=None,
            condition_right_operator=None,
            description="累積GPAを答えてください。（例：私の累積GPAは〇〇.〇です。）",
            extraction_data_type="float"
        )
    )
    forth_group_id = question_groups[3].id
    questions.append(
        InterviewQuestionModel(
            id=uuid.uuid4(),
            group_id=forth_group_id,
            question="出席率は？",
            order=1,
            prompt="Please extract the attendance rate from the following text. Extract only the numerical value.",
            condition_target_operand_data_type="int",
            condition_left_operand=None,
            condition_left_operator=None,
            condition_right_operand=None,
            condition_right_operator=None,
            description="出席率を答えてください。（例：私の出席率は〇〇%です。）",
            extraction_data_type="int"
        )
    )
    questions.append(
        InterviewQuestionModel(
            id=uuid.uuid4(),
            group_id=forth_group_id,
            question="出席率が低いですが、この出席率の理由は？",
            order=2,
            prompt="Please extract the factors causing low attendance rate from the following text.",
            condition_target_operand_data_type="int",
            condition_left_operand="80",
            condition_left_operator=">",
            condition_right_operand=None,
            condition_right_operator=None,
            description="出席率が低めな理由を答えてください。（例：私は〇〇という理由で出席率が低いです。）",
            extraction_data_type="str"
        )
    )
    fifth_group_id = question_groups[4].id
    questions.append(
        InterviewQuestionModel(
            id=uuid.uuid4(),
            group_id=fifth_group_id,
            question="学校生活で困っていることは？",
            order=1,
            prompt="Please extract the factors causing difficulties in school life from the following text. If no difficulties are observed, input 'None'.",
            condition_target_operand_data_type="str",
            condition_left_operand=None,
            condition_left_operator=None,
            condition_right_operand=None,
            condition_right_operator=None,
            description="学校生活で困っていることがあれあお気軽にお話しください。特にない場合は「困っていることは特にありません」などとご回答ください。",
            extraction_data_type="str",
        )
    )
    sixth_group_id = question_groups[5].id
    questions.append(
        InterviewQuestionModel(
            id=uuid.uuid4(),
            group_id=sixth_group_id,
            question="教員との面談を希望しますか？",
            order=1,
            prompt="Please extract whether a meeting with the teacher is requested from the following text. Extract as `True` or `False`.",
            condition_target_operand_data_type="bool",
            condition_left_operand=None,
            condition_left_operator=None,
            condition_right_operand=None,
            condition_right_operator=None,
            description="実際に対面で教員と面談を実施することが可能です。面談の実施の希望の有無をお答えください。（）",
            extraction_data_type="bool"
        )
    )

    session.add_all(questions)
    session.commit()
    return questions


# utils...

def get_number_of_rows(session: Session, model: EntityBaseModel) -> int:
    return session.query(model).count()


def create_student_user(db_session: Session, semester: int):
    user_id = uuid.uuid4()
    student_id = uuid.uuid4()
    student_number = str(int(random.uniform(0000000, 9999999)))
    user_model = UserModel(
        id=user_id,
        name=f"Student {student_number}さん",
        email=f"a{student_number}@planet.kanazawa-it.ac.jp",
        is_admin=False,
    )
    student_model = StudentModel(
        id=student_id,
        user_id=user_id,
        student_id=student_number,
        department="情報工学部",
        semester=semester,
    )
    users_crud.create(db_session=db_session,
                      obj_in=user_model)
    students_crud.create(db_session=db_session,
                         obj_in=student_model)
    return user_model
