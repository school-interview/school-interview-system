from typing import List
from sqlalchemy import Row, Tuple
from src.crud import InterviewAnalyticsCrud
from src.models import InterviewAnalyticsModel, InterviewAnalytics, InterviewSessionModel, InterviewSession, UserModel, User, InterviewReport
from sqlalchemy.orm import Session


def collect_interview_reports(db_session: Session) -> List[InterviewReport]:
    # TODO 期間とかユーザーとかで絞り込めるようにする
    analytics_crud = InterviewAnalyticsCrud(InterviewAnalyticsModel)
    rows: List[Row[Tuple[InterviewAnalyticsModel, InterviewSessionModel,
                         UserModel]]] = analytics_crud.get_multi_with_user_and_session(db_session)
    interview_reports = list(
        map(
            lambda row: InterviewReport(
                user=row[2].convertToPydantic(User),
                interview_session=row[1].convertToPydantic(InterviewSession),
                analytics=row[0].convertToPydantic(InterviewAnalytics)
            ),
            rows
        )
    )
    return interview_reports
