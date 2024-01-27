FROM python:3.10.13-slim

RUN pip install mlflow[extras]==2.9.2 && \
    pip install psycopg2-binary==2.9.9


EXPOSE 5000
ENTRYPOINT ["mlflow", "server", "--host", "0.0.0.0"]
