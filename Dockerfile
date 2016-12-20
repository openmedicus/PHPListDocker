FROM openmedicus/centos-lamp:latest
MAINTAINER Mikkel Kruse Johnsen <mikkel@xmedicus.com>

RUN sed -i -e "s/\/var\/www\/html/\/var\/www\/html\/public_html/g" /etc/httpd/conf/httpd.conf
RUN sed -i -e "s/DirectoryIndex index\.html/DirectoryIndex index\.php index\.html/g" /etc/httpd/conf/httpd.conf

ADD phplist-3.2.6.tgz /
RUN mv phplist-3.2.6/* /var/www/html/ ; \
	chown -R apache:apache /var/www/html

