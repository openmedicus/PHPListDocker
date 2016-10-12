FROM openmedicus/centos-lamp:latest
MAINTAINER Mikkel Kruse Johnsen <mikkel@xmedicus.com>

ADD phplist-3.2.5.tgz /
RUN mv phplist-3.2.5/* /var/www/html/ ; \
	chown -R apache:apache /var/www/html

