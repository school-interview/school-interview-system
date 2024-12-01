import uuid
from sqlalchemy.orm import Session
from src.models import TeacherModel, EntityBaseModel, InterviewQuestionModel, InterviewQuestionGroupModel
from typing import List, Type
from sqlalchemy.orm import Session


def seed_all(session: Session):
    seed_teachers(session)
    question_groups = seed_question_groups(session)
    if len(question_groups) > 0:
        seed_questions(session, question_groups)


def seed_teachers(session: Session):
    row_count = get_number_of_rows(session, TeacherModel)
    if row_count > 0:
        return
    teachers: List[TeacherModel] = [
        TeacherModel(
            id=uuid.uuid4(),
            name="サンプル講師",
            description="サンプルのイラストの講師です。",
            image_url="/static/teacher1.png"
        )
    ]
    session.add_all(teachers)
    session.commit()


def seed_question_groups(session: Session):
    row_count = get_number_of_rows(session, InterviewQuestionGroupModel)
    if row_count > 0:
        return []
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
            previous_extracted_value_type="int",
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
            previous_extracted_value_type=None,
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
            previous_extracted_value_type=None,
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
            previous_extracted_value_type=None,
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
            previous_extracted_value_type="float",
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
            previous_extracted_value_type="str",
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
            previous_extracted_value_type="bool",
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


def get_number_of_rows(session: Session, model: Type[EntityBaseModel]) -> int:
    return session.query(model).count()
