# Tools 概要

このディレクトリには開発時に便利かもしれないスクリプトを格納しています。

# `switch_role.py`

このスクリプトで、一般アカウントと管理者アカウントを切り替えることができます。

（一般向け機能と管理者向け機能の動作を確認する際などに切り替える目的です。）

切り替えたいユーザーの ID とロールを入力することで切り替えることができます。

```
python tools/switch_role.py

切り替えるユーザーのIDを入力してください:
切り替えるユーザーのロールを入力してください (admin/student):

```

このツールを実行する前に DB サーバーが起動している必要があります。

もし起動していない場合は以下のコマンドで起動しましょう。(DB だけ起動する)

```
docker compose --profile db up
```

## 注意事項

元々、管理者アカウントのユーザーが学生アカウントに切り替える場合は注意が必要です。

面談システムのいくつかの機能は、面談開始時のプロフィール入力を済ませてあることを前提としています。(`StudentModel`の`student_id`や`department`,`semester`など)

**これらの記録がないと誤作動を起こす可能性があるので、pgAdmin のようなツールを使って Students テーブルの該当ユーザーの`student_id`や`department`,`semester`などのフィールドを直接書き込んでください。**

↑ 　これも switch_role.py で対応できるように今度修正しますね。（以下はその issue）

https://github.com/orgs/school-interview/projects/2/views/1?pane=issue&itemId=84930990&issue=school-interview%7Cschool-interview-system%7C140
