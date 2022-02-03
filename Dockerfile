FROM python:3.9.7-bullseye

RUN apt update \
    && yes | apt upgrade

COPY main.py .
COPY gunicorn_conf.py .
COPY requirements.txt .

RUN pip install -r requirements.txt

EXPOSE 8000

ENTRYPOINT uvicorn --host 0.0.0.0 main:app --reload
