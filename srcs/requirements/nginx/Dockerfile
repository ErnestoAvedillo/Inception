#docker buildx build --help
FROM debian:11-slim

ARG NGINX_PATH

RUN apt-get -qq update -y 
RUN apt-get -qq install apt-file
RUN apt-file update -y
RUN apt-get -qq install nginx openssl vim -y

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/eavedill.42.fr.key -out /etc/nginx/eavedill.42.fr.crt -subj "/C=/ST=/L=/O=/OU=/CN=/UID="

COPY nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p ${NGINX_PATH}/web_page
COPY web/* ${NGINX_PATH}/web_page/
RUN chmod -R 755 ${NGINX_PATH}/web_page

EXPOSE 443 

CMD ["nginx", "-g", "daemon off;"]
