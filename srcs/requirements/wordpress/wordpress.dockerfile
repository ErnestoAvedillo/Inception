FROM debian:10-slim

ARG WP_PATH

RUN apt-get update -y && apt-get install -y php-mysql php-fpm mariadb-server mariadb-client wget tar

WORKDIR  /var/www/

RUN wget https://wordpress.org/latest.tar.gz

RUN mkdir -p ${WP_PATH}

RUN tar -xvf latest.tar.gz -C ${WP_PATH}

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

RUN chown -R www-data:www-data ${WP_PATH}

COPY config/wordpress.conf /etc/nginx/sites-available/wordpress.conf

COPY config/wp-config.php /

COPY config/script.sh /

RUN chmod +x /script.sh

CMD ["/script.sh"]
