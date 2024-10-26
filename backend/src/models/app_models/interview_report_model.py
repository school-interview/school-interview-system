from pydantic import BaseModel
from src.models.db_models.user_model import UserModel
from src.models.db_models.interview_analytics_model import InterviewAnalyticsModel
from src.models.db_models.interview_session_model import InterviewSessionModel

class InterviewReportModel(BaseModel):
		user: UserModel
		interview_session: InterviewSessionModel
		analytics: InterviewAnalyticsModel