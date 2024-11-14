from sys import path
from os import getcwd
from uuid import UUID, uuid4
path.append(getcwd())  # noqa
from src.database import connect_db, session_factory
from src.crud import UsersCrud
from src.models import UserModel
from src.usecases import delete_user

# 指定したユーザーを削除するためのスクリプト


print("Connecting to database...")
connect_db()
print("Connected!")


user_id = input("削除するユーザーのIDを入力してください: ")

try:
    user_id = UUID(user_id)
except ValueError:
    print("IDが不正です。UUID形式で入力してください。")
    exit(1)

session_generator = session_factory()
db_session = session_generator.__next__()
users_crud = UsersCrud(UserModel)

try:
    user_model = users_crud.get(db_session, user_id)
    if user_model is None:
        print("ユーザーが見つかりませんでした")
        exit(1)
    # TODO: relationship()のcascadeオプションを使わないと、ORMレベルで削除
    delete_user(db_session, user_id)
    print("ユーザーを削除しました")
finally:
    db_session.close()
