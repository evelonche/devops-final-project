FROM python:3.10

RUN apt-get update \
    && apt-get upgrade -y \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY ./requirements.txt /app
RUN pip install -r requirements.txt

COPY ./training /app
#RUN mkdir -p /app/mlruns

ENTRYPOINT [ "python3", "train.py" ]

