FROM wordpress:fpm-alpine

RUN sudo apt update && sudo apt install wordpress
