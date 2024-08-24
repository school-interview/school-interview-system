# School Interview: Backend Application

This is the backend application for school interview system.

## Set Up

This project requires Docker.

If you haven't installed Docker Desktop, you can [download and install it here.](https://docs.docker.com/desktop/install/mac-install/)

After you install Docker Desktop, you can launch the backend app with these commands below. (This is all you need to launch it 😎)

```
cd backend
docker compose up --build
```

The app is available on `http://localhost:8000`.

(When `--build` option is specified, Docker automatically build the docker image before the container launches.)

## Swagger

You can view Swagger by accessing `/docs` endopoint.

```
http://localhost:8000/docs
```

# For backend developer

🔔 If you haven't installed `Poetry` (package manager for Python, like `npm` for Nodejs), you need to install it first.

You can read [the official document](https://python-poetry.org/docs/#installing-with-pipx) to install it.

(I used `With pipx` installation method to install Poetry. Then, you need HomeBrew. If you have any trouble with installing it, feel free to ask me, DanFujisaki. It's pretty complicated.😅)

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

./backend/launch-server.sh

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
