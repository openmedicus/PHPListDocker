VERSION = 3.6.0
PHP_VERSION = 7.1

all: pull build tag push

pull:
	podman pull openmedicus/centos-lamp:$(PHP_VERSION)

build:
	cp -f Dockerfile.in Dockerfile
	sed -i -e 's!@PHPLIST_VERSION@!$(VERSION)!g' Dockerfile
	sed -i -e 's!@PHP_VERSION@!$(PHP_VERSION)!g' Dockerfile
	podman build --format=docker --no-cache -t phplist .

tag:
	podman tag phplist openmedicus/phplist:$(VERSION)
	podman tag phplist openmedicus/phplist:latest

push:
	podman push openmedicus/phplist:$(VERSION)
	podman push openmedicus/phplist:latest

run:
	podman run -i -t phplist /bin/bash
