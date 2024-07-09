FROM ubuntu

RUN apt update -y 
RUN apt install nginx -y

COPY ../web/* /usr/share/nginx/html

RUN ls /usr/share/nginx/html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
