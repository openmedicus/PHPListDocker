VERSION = 3.3.4

all: pull build tag push

pull:
	sudo docker pull openmedicus/centos-lamp:latest

build:
	sudo docker build -t phplist .

tag:
	sudo docker tag phplist openmedicus/phplist:$(VERSION)
	sudo docker tag phplist openmedicus/phplist:latest

push:
	sudo docker push openmedicus/phplist:$(VERSION)
	sudo docker push openmedicus/phplist:latest

run:
	sudo docker run -i -t phplist /bin/bash
