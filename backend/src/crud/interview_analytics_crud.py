from src.crud.base_crud import BaseCrud
from src.models import InterviewQuestionModel, InterviewQuestion, InterviewQuestionUpdate


class InterviewQuestionsCrud(BaseCrud[InterviewQuestionModel, InterviewQuestion, InterviewQuestionUpdate]):
    pass
