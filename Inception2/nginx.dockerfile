FROM nginx:alpine

RUN sudo apt update -y && sudo apt install nginx -y

COPY web /usr/share/nginx/html

