# admin.sssua.org server host
#
# VERSION               1.0.0

# FROM  grengojbo/python:latest
#FROM          grengojbo/django:1.5.9
FROM          grengojbo/django:latest
MAINTAINER    Oleg Dolya "oleg.dolya@gmail.com"

RUN mkdir -p /app/db
RUN mkdir -p /app/log
RUN mkdir -p /app/pids
RUN mkdir -p /app/shared
RUN mkdir -p /app/public/media
ADD keep /app/public/media/.keep

# Sharing sshd port to host
EXPOSE 8000

VOLUME /app/public

ADD manage.py /app/manage.py
ADD gunicorn.py /app/gunicorn.py
ADD userena /app/userena
ADD bin /app/bin
ADD doc /app/doc
ADD fixtures /app/fixtures
ADD locale /app/locale
ADD DjangoApp /app/DjangoApp
#ADD lib/imagestore /app/imagestore
ADD requirements /app/requirements

ADD public /app/public
ADD profiles /app/profiles
ADD templates /app/templates
ADD sss /app/sss

#RUN cd /home/dev/current && find . | egrep *.pyc$ | xargs rm

#RUN pip install BeautifulSoup
RUN pip install -r /app/requirements/prod.txt

WORKDIR /app
#RUN ./manage.py collectstatic --noinput
#RUN ./manage.py compress --force
#RUN ./manage.py compile_pyc

RUN git config --global user.email "oleg.dolya@gmail.com" && git config --global user.name "grengojbo"

ENTRYPOINT ["/app/bin/boot"]

#CMD ["./manage.py", "runserver", "0.0.0.0:8000"]
CMD ["/usr/local/bin/gunicorn", "-c", "/app/gunicorn.py", "--preload", "DjangoApp.wsgi:application"]
#/usr/local/bin/gunicorn -c /app/gunicorn.py --preload DjangoApp.wsgi:application
