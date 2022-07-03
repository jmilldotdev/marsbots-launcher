# syntax=docker/dockerfile:1
FROM python:3.9-buster AS python
WORKDIR /bots
COPY web web
COPY requirements.txt requirements.txt
COPY .env .env
COPY bot.py bot.py
COPY credential.json credential.json

RUN pip install -r requirements.txt

RUN apt-get update && apt-get install -y nodejs npm
RUN npm install -g pm2@latest

CMD ["uvicorn", "web.api:app", "--host", "0.0.0.0", "--port", "80"]