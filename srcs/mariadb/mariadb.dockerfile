FROM debian:10-slim

RUN sudo apt update && sudo apt install mariadb-server
