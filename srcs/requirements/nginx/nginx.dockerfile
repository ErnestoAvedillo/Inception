#docker buildx build --help
FROM debian:10-slim

ARG	NGINX_PATH WP_PATH MARIADB_PATH

RUN apt-get update -y 
RUN apt-get install nginx openssl -y

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/eavedill.42.fr.key -out /etc/nginx/eavedill.42.fr.crt -subj "/C=/ST=/L=/O=/OU=/CN=/UID="

COPY nginx.conf /etc/nginx/nginx.conf

COPY web/* $NGINX_PATH

EXPOSE 443 

CMD ["nginx", "-g", "daemon off;"]