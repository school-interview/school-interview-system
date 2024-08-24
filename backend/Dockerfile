FROM python:3.12.5-alpine
WORKDIR /app
RUN pip install poetry
COPY ./pyproject.toml ./poetry.lock* ./
RUN poetry install
CMD ["./launch-server.sh"]