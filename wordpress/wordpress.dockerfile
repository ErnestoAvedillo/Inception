FROM debian:11-slim

RUN apt update -y && apt install -y php-mysql php-fpm mariadb-server mariadb-client wget tar

RUN wget https://wordpress.org/latest.tar.gz

RUN tar -xvf latest.tar.gz

#COPY ./wordpress/wp-config.php /wordpress/wp-config.php

#COPY ./wordpress/wordpress.conf /etc/nginx/sites-available/wordpress.conf

