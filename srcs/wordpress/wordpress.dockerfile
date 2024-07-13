FROM debian:11-slim

RUN apt update -y && apt install -y php-mysql php-fpm mariadb-server mariadb-client wget tar

RUN wget https://wordpress.org/latest.tar.gz

RUN tar -xvf latest.tar.gz

COPY config/wp-config.php /srv/www/wordpress/wp-config.php

COPY config/wordpress.conf /etc/nginx/sites-available/wordpress.conf

