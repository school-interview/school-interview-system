from src.models import StudentModel, Student, StudentUpdate
from src.crud.base_crud import BaseCrud


class StudentsCrud(BaseCrud[StudentModel, Student, StudentUpdate]):
    pass
