VERSION = 3.6.6
PHP_VERSION = 7.1

all: pull build tag push

pull:
	podman pull docker.io/openmedicus/centos-lamp:$(PHP_VERSION)

build:
	cp -f Dockerfile.in Dockerfile
	sed -i -e 's!@PHPLIST_VERSION@!$(VERSION)!g' Dockerfile
	sed -i -e 's!@PHP_VERSION@!$(PHP_VERSION)!g' Dockerfile
	podman build --format=docker --no-cache -t phplist .

tag:
	podman tag phplist openmedicus/phplist:$(VERSION)

push:
	podman push openmedicus/phplist:$(VERSION)

run:
	podman run -i -t phplist /bin/bash
