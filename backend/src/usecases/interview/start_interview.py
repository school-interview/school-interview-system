
from datetime import datetime
import logging
import os
from time import time
from typing import Optional
from uuid import uuid4, UUID
from sqlalchemy.orm import Session
from src.usecases.interview.finish_interview import finish_interview
from src.models import InterviewSessionModel, TeacherResponse, InterviewQuestionModel, InterviewQuestion, SchoolCredit, Gpa, AttendanceRate, Trouble, PreferInPerson, ExtractionResult, TeacherModel


def start_interview(session: Session, user_id: UUID, teacher_id: UUID, delete_current_interview: bool = True):
    current_interview_query = session.query(
        InterviewSessionModel).join(TeacherModel, InterviewSessionModel.teacher_id == TeacherModel.id).where(InterviewSessionModel.user_id == user_id and InterviewSessionModel.done == False)
    current_interview_rows: Optional[InterviewSessionModel] = session.execute(
        current_interview_query).first()
    current_interview = current_interview_rows[0] if current_interview_rows else None
    if current_interview and delete_current_interview:
        finish_interview(session, current_interview)
        session.commit()
    elif current_interview_rows:
        raise Exception(
            "The user {} are already in an interview session.".format(user_id))
    interview_session = InterviewSessionModel(
        id=uuid4(),
        user_id=user_id,
        teacher_id=teacher_id,
        start_at=datetime.now(),
        progress=1,
        done=False
    )
    session.add(interview_session)
    session.commit()
    current_interview_rows: Optional[InterviewSessionModel] = session.execute(
        current_interview_query).first()
    current_interview = current_interview_rows[0] if current_interview_rows else None
    return current_interview