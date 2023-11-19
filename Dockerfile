FROM python:3.9-alpine

WORKDIR /flask_app

COPY requirements.txt .

COPY /home/ec2-user/bin/kubectl kubectl

RUN pip install --no-cache-dir -r requirements.txt

RUN pip install pytest

RUN pwd

COPY app/ .

COPY tests/ app/tests/

CMD [ "python", "app.py" ]   

