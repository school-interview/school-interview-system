FROM python:3.12.5-bookworm
WORKDIR /app
RUN apt install libpq-dev make gcc g++ 
RUN pip install poetry
COPY ./pyproject.toml ./poetry.toml ./poetry.lock* ./
# RUN export SHELL="/bin/sh"
RUN poetry install --no-root
# RUN poetry shell
CMD ["./launch-server-docker.sh"]
# CMD ["tail", "-F", "/dev/null"]