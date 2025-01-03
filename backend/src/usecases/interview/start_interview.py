
from datetime import datetime
import logging
import os
from time import time
from typing import Optional
from uuid import uuid4, UUID
from sqlalchemy.orm import Session
from src.usecases.interview.finish_interview import finish_interview
from src.models import InterviewSessionModel, TeacherResponse, InterviewQuestionModel, InterviewQuestion, UserModel, ExtractionResult, TeacherModel, InterviewRecordModel, InterviewAlreadyStartedException, Teacher, InterviewQuestionGroupModel
from src.crud import InterviewQuestionGroupsCrud


def start_interview(db_session: Session, user_id: UUID, teacher_id: UUID, delete_current_interview: bool = True):
    current_interview_query = db_session.query(
        InterviewSessionModel).join(TeacherModel, InterviewSessionModel.teacher_id == TeacherModel.id).join(UserModel, InterviewSessionModel.user_id == UserModel.id).where(InterviewSessionModel.user_id == user_id and InterviewSessionModel.done == False)
    current_interview_rows = db_session.execute(
        current_interview_query).first()
    current_interview: Optional[InterviewSessionModel] = current_interview_rows[0] if current_interview_rows else None

    if current_interview and delete_current_interview:
        finish_interview(db_session, current_interview)
        db_session.commit()
    elif current_interview:
        raise InterviewAlreadyStartedException(user_id)

    groups_crud = InterviewQuestionGroupsCrud(InterviewQuestionGroupModel)
    groups = groups_crud.get_multi_with_questions(db_session)
    interview_session = InterviewSessionModel(
        id=uuid4(),
        user_id=user_id,
        teacher_id=teacher_id,
        start_at=datetime.now(),
        current_question_id=groups[0].questions[0].id,
        done=False
    )
    db_session.add(interview_session)
    db_session.commit()
    current_interview_query = (
        db_session.query(InterviewSessionModel)
        .join(TeacherModel, InterviewSessionModel.teacher_id == TeacherModel.id)
        .join(UserModel, InterviewSessionModel.user_id == UserModel.id)
        .join(InterviewQuestionModel, InterviewSessionModel.current_question_id == InterviewQuestionModel.id)
        .where(InterviewSessionModel.id == interview_session.id)
    )
    # .where(InterviewSessionModel.user_id == user_id and InterviewSessionModel.done == False)でなぜか同じ結果にならないことがある。↑ 調査。問題としてはfinish_interviewでdoneがTrueになってDBに格納されているはずなのにそうなってない？よくわかっていない。
    current_interview_rows = db_session.execute(
        current_interview_query).first()
    current_interview = current_interview_rows[0] if current_interview_rows else None
    return current_interview
