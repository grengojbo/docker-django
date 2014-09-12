NAME="appname"
PUBLIC_PORT=8001
IMAGE_NAME = "grengojbo/${NAME}"
SITE="example.com"

.PHONY: all run clean push create shell build destroy make_trans syncdb compile_trans static

all: push

push:
	git push deis master

clean:
	#docker rmi ${IMAGE_NAME}
	deis apps:destroy --app=${NAME} --confirm=${NAME}

create:
	deis create ${NAME}
	deis domains:add ${SITE}
	deis domains:add www.${SITE}
	deis limits:set -m cmd=128M

run:
	./manage.py runserver 0.0.0.0:8000

shell:
	sudo docker run --rm -v /storage/${NAME}:/storage/${NAME} --name ${NAME} -e NAME_APP=${NAME} -i -t -p ${PUBLIC_PORT}:8000 ${IMAGE_NAME} /bin/bash

build:
	@sudo docker build -t ${IMAGE_NAME} .
	@echo Run conteiners >  make shell
	@sudo docker images | grep ${IMAGE_NAME} | awk '{print $7}'
	@echo ---------------------------------

make_trans:
	./manage.py makemessages -a -e 'py,html,haml'

install:
	fleetctl submit ${NAME}.service
	fleetctl submit ${NAME}-log.service

destroy:
	deis apps:destroy --app=${NAME} --confirm=${NAME}

static:
	./manage.py collectstatic --noinput
	#./manage.py compress --force

syncdb:
	./manage.py syncdb --migrate

compile_trans:
	make locale/*/LC_MESSAGES/django.mo

locale/%/LC_MESSAGES/django.mo: locale/%/LC_MESSAGES/django.po
	./bin/django compilemessages -l $(word 2,$(subst /, ,$@))

locale/*/LC_MESSAGES/django.po:
