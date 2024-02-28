FROM python:3-slim
ENV POETRY_HOME=/opt/poetry
ENV POETRY_VIRTUALENVS_IN_PROJECT=true
ENV PATH="$POETRY_HOME/bin:$PATH"
WORKDIR /app
RUN apt update && apt install gcc -y &&  python -c 'from urllib.request import urlopen; print(urlopen("https://install.python-poetry.org").read().decode())' | python -
ENTRYPOINT poetry install --no-interaction --no-ansi -vvvv \
  && poetry run python main.py
