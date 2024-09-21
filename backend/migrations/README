# Migrations with Alembic

Alembic is a python library for migrating databse and often used with SQLAlchemy.

The article below was very helpful.

- [DB マイグレーションツールの Alembic の使い方](https://zenn.dev/shimakaze_soft/articles/4c0784d9a87751)

## マイグレーションファイルの自動生成

```
$ alembic revision --autogenerate -m "create tables"
```

## DB にマイグレーションファイルを反映する

最新のマイグレーションファイルを反映させる。

```
$ alembic upgrade head
```
