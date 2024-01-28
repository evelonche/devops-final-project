FROM python:3.10.13-slim

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

EXPOSE 5000
ENTRYPOINT ["mlflow", "server", "--host", "0.0.0.0"]
