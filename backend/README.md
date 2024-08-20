# School Interview: Banckend Application

This is the backend application for school interview system.

## Set-up

```
poetry shell
poetry install
```

## Launch server

### 1. Activate virtual environment

(If you have already activated it, you don't have to execute this command. You can skip this step.)

```
poetry shell
```

### 2. Launch FastAPI server

I wrote shell script to launch it in `launch-server.sh`.
You can execute it to launch the app.

```

./backend/launcb-server.sh

```

## How to activate virtual environment

[Using yor virtual environment shell | Poetry Official Document](https://python-poetry.org/docs/basic-usage/#using-your-virtual-environment)

Type the command below in Terminal at the `backend` directory.

If this is your first time to execute the command, poetry automatically create virtual environment for you and activate the virtual environment.

```
poetry shell
```

If you just wanna execute a command in the environment, you can use `poetry run` command.

```
poertry run <command here...>
```

## Swagger

You can view Swagger by accessing `/docs` endopoint.

```
http://127.0.0.1:8000/docs
```
