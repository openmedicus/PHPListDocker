# PHPListDocker

The PHPList installed on CentOS 7.

### Pull image

```
docker pull openmedicus/phplist
```

### Using config file on host

```
mkdir /www/phplist/lists
touch /www/phplist/config.php
```

SELinux:

```
chcon -Rt svirt_sandbox_file_t /www/
```

```
docker run --name=phplist -p 8080:80 -v /www/phplist/config.php:/var/www/html/application/config/config.php:rw -d openmedicus/phplist
```


### Systemd

/etc/systemd/system/docker-phplist.service

```
[Unit]
Description=PHPList container
Requires=docker.service
After=docker.service

[Service]
Restart=always
ExecStart=/usr/bin/docker run --name=phplist -p 8080:80 -v /www/phplist/config.php:/var/www/html/application/config/config.php:rw openmedicus/phplist
ExecStop=/usr/bin/docker stop -t 2 phplist
ExecStopPost=/usr/bin/docker rm -f phplist

[Install]
WantedBy=default.target
```

Now reload systemd, enable and start
```
# systemctl daemon-reload
# systemctl enable docker-phplist
# systemctl start docker-phplist
```

### Nginx

```
upstream phplist.local {
    server 172.17.0.1:8080;
}

server {
        listen 80;
        server_name phplist.test.com;
        access_log /var/log/nginx/phplist.test.com.log;

        location / {
                proxy_pass       http://phplist.local;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto https;
                proxy_redirect   off;
        }
}

```
