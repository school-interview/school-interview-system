from pydantic import BaseModel
from src.models.db_models.user_model import User
from src.models.db_models.interview_analytics_model import InterviewAnalytics
from src.models.db_models.interview_session_model import InterviewSession


class InterviewReport(BaseModel):
    user: User
    interview_session: InterviewSession
    analytics: InterviewAnalytics
