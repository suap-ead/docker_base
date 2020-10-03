FROM python:3.8-alpine

ENV PYTHONUNBUFFERED 1

RUN apk update && \
    apk add postgresql-libs py3-cffi libjpeg && \
    apk add --virtual .build-deps gcc python3-dev musl-dev postgresql-dev jpeg-dev zlib-dev libffi-dev && \
    pip install psycopg2-binary pillow social-auth-app-django && \
    apk --purge del .build-deps gcc python3-dev musl-dev postgresql-dev



RUN apk update && \
    apk --purge del .build-deps

ADD install_packages.sh .
ADD startup.sh .

ADD requirements.txt . 
RUN pip install -r /requirements.txt

WORKDIR /apps/app
CMD /startup.sh
