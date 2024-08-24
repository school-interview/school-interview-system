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
