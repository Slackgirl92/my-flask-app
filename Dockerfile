FROM python:3.9-alpine

WORKDIR /flask_app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

RUN pip install pytest

RUN pwd

COPY app/ .

COPY tests/ app/tests/

EXPOSE 5001

CMD [ "python", "app.py" ]   

