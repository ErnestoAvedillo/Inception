#docker buildx build --help
FROM debian:11-slim

RUN apt-get -qq update -y 
RUN apt-get -qq install nginx openssl vim -y

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/eavedill.42.fr.key -out /etc/nginx/eavedill.42.fr.crt -subj "/C=/ST=/L=/O=/OU=/CN=/UID="

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 443 

CMD ["nginx", "-g", "daemon off;"]
