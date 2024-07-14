FROM debian:11-slim

RUN apt-get update -y && apt-get install -y php-mysql php-fpm mariadb-server mariadb-client wget tar

RUN wget https://wordpress.org/latest.tar.gz

RUN mkdir -p /srv/www/wordpress

RUN tar -xvf latest.tar.gz -C /srv/www/wordpress

RUN chown -R www-data:www-data /srv/www/wordpress

COPY config/wordpress.conf /etc/nginx/sites-available/wordpress.conf

COPY config/wp-config.php /

COPY config/script.sh /

RUN chmod +x /script.sh

CMD ["/script.sh"]