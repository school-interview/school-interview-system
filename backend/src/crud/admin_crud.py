from src.crud.base_crud import BaseCrud
from src.models import AdminModel, Admin, AdminUpdate


class AdminCrud(BaseCrud[AdminModel, Admin, AdminUpdate]):
    pass
