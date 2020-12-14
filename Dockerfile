FROM python:latest

WORKDIR /stockage

ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

COPY requirements.txt requirements.txt
COPY . .
RUN pip install -r requirements.txt

EXPOSE 5000
RUN wget https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh -P /scripts
RUN chmod +x /scripts/wait-for-it.sh
ENTRYPOINT ["/scripts/wait-for-it.sh", "db:5432", "--"]

CMD ["python","app.py","runserver","--host=0.0.0.0","--threaded"]