from sys import path
from os import getcwd
from uuid import UUID, uuid4
path.append(getcwd())  # noqa
from src.database import connect_db, session_factory
from src.crud import UsersCrud, AdminCrud, StudentsCrud
from src.models import UserModel, UserRoleUpdate, AdminModel, StudentModel

# 開発時に一般アカウントと管理者アカウントを切り替えるためのスクリプト


print("Connecting to database...")
connect_db()
print("Connected!")

user_id = input("切り替えるユーザーのIDを入力してください: ")
try:
    user_id = UUID(user_id)
except ValueError:
    print("IDが不正です。UUID形式で入力してください。")
    exit(1)

role = input("切り替えるユーザーのロールを入力してください (admin/student): ")
if role not in ["admin", "student"]:
    print("ロールが不正です")
    exit(1)

is_admin = role == "admin"
session_generator = session_factory()
db_session = session_generator.__next__()

try:
    user_crud = UsersCrud(UserModel)
    user_model = user_crud.get(db_session, user_id)
    if user_model is None:
        print("ユーザーが見つかりませんでした")
        exit(1)

    update = UserRoleUpdate(is_admin=is_admin)
    user_crud.update(db_session=db_session, db_obj=user_model, obj_in=update)
    print("ユーザーのロールを切り替えました")
    if is_admin:
        admin_crud = AdminCrud(AdminModel)
        admin_model = admin_crud.get_by_user_id(db_session, user_id)
        if not admin_model:
            admin_model = AdminModel(id=uuid4(), user_id=user_id)
            admin_crud.create(db_session, obj_in=admin_model)
    else:
        student_crud = StudentsCrud(StudentModel)
        student_model = student_crud.get_by_user_id(db_session, user_id)
        if not student_model:
            student_model = StudentModel(id=uuid4(), user_id=user_id)
            student_crud.create(db_session, obj_in=student_model)


finally:
    db_session.close()
