VERSION = 3.2.6

all: build tag push

pull:
	sudo docker pull openmedicus/centos-lamp:latest

build:
	sudo docker build -t phplist .

push:
	sudo docker tag phplist openmedicus/phplist:$(VERSION)
	sudo docker push openmedicus/phplist
	sudo docker tag phplist openmedicus/phplist:latest
	sudo docker push openmedicus/phplist

run:
	sudo docker run -i -t phplist /bin/bash
