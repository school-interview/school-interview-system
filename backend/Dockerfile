FROM python:3.12.5-alpine
WORKDIR /app
RUN pip install poetry
COPY ./pyproject.toml ./poetry.toml ./poetry.lock* ./
# RUN export SHELL="/bin/sh"
RUN poetry install --no-root
# RUN poetry shell
CMD ["./launch-server.sh"]
# CMD ["tail", "-F", "/dev/null"]