all:	up

IMAGES = $$(docker images -aq)
CONTAINERS= $$(docker ps -aq)
VOLUMES= $$(docker volume ls -q)

up:
	-@mkdir -p $(HOME)/data/wordpress
	-@mkdir -p $(HOME)/data/mariadb
	-@docker-compose -f ./srcs/docker-compose.yaml --env-file ./srcs/.env up -d --remove-orphans --quiet-pull --build

down:
	-@docker-compose -f ./srcs/docker-compose.yaml --env-file ./srcs/.env down

start:
	-@docker-compose -f ./srcs/docker-compose.yaml --env-file ./srcs/.env start

stop:
	-@docker-compose -f ./srcs/docker-compose.yaml --env-file ./srcs/.env stop

stat: 
	@echo "-------images---------"
	@docker images -a
	@echo "-------volumes---------"
	@docker volume ls
	@echo "-------docker ps---------"
	@docker ps -a

rma: stop rm rmi rmv
rm:
	-@docker rm $(CONTAINERS) -f
rmi:
	-@docker rmi $(IMAGES) -f
rmv:
	-@docker volume rm $(VOLUMES) -f
	-@rm -rfd $(HOME)/data/wordpress/*
	-@rm -rfd $(HOME)/data/mariadb/*
init_docker:
	@sudo systemctl start docker
	@sudo systemctl start docker-compose

clean:
	@docker system prune -a

print:
	@echo "Variable IMAGES= "$(IMAGES)
	@echo "Variable CONTAINERS =" $(CONTAINERS)
	@echo "Variable VOLUMES =" $(VOLUMES)

debma:
	@docker exec -it $$(docker ps |grep mariadb| awk '{print $$1}') /bin/bash
debwp:
	@docker exec -it $$(docker ps |grep wordpress| awk '{print $$1}') /bin/bash
debng:
	@docker exec -it $$(docker ps |grep nginx| awk '{print $$1}') /bin/bash

re : rma up

help:
	@echo "Possible targets"
	@echo "up	   :build and run all services"
	@echo "down        :down all services"
	@echo "start       :start all services"
	@echo "stop        :Stop all services"
	@echo "status      :print status of all docker images and containers"
	@echo "rm          :remove all containers"
	@echo "rmi         :Remove all images"
	@echo "init-docker :start docker service"
	@echo "print       :Print images ID"
	@echo "debmaria    :Docker exec -it (container) /bin/bash"
	@echo "debwp       :Docker exec -it (container) /bin/bash"

.PHONY: up down start stop stat rma rm rmi rmv init_docker print help re debmaria debwp clean
