from src.crud.base_crud import BaseCrud
from src.models import InterviewSessionModel, InterviewSession, InterviewSessionUpdate


class InterviewSessionsCrud(BaseCrud[InterviewSessionModel, InterviewSession, InterviewSessionUpdate]):
    pass
