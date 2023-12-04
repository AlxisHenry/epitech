# Dockerfile
FROM python:3.9.10-alpine3.14
WORKDIR /srv
RUN pip install --upgrade pip
RUN pip install flask
RUN pip install Flask-SQLAlchemy
run pip install PyMySQL
COPY . /srv
ENV APP=project
CMD ["python","project.py"]