FROM python:3.8

WORKDIR /app

COPY requirements.txt requirements.txt
COPY app.py app.py

RUN pip3 install -r requirements.txt

ENV FLASK_RUN_PORT=6969

CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]
