all:	up

IMAGES = $$(docker images -aq)
CONTAINERS= $$(docker ps -aq)
VOLUMES= $$(docker volume ls -q)

up:
	@docker-compose -f ./srcs/docker-compose.yaml --env-file ./srcs/var.env up -d
	@echo "-------docker ps---------"
	@docker ps -a
	@echo "-------images---------"
	@docker images -a
	@echo "-------volumes---------"
	@docker volume ls

down:
	docker-compose -f ./srcs/docker-compose.yaml --env-file ./srcs/var.env down

start:
	docker-compose -f ./srcs/docker-compose.yaml --env-file ./srcs/var.env start

stop:
	docker-compose -f ./srcs/docker-compose.yaml --env-file ./srcs/var.env stop

stat: 
	@echo "-------docker ps---------"
	@docker ps -a
	@echo "-------images---------"
	@docker images -a
	@echo "-------volumes---------"
	@docker volume ls

rma: stop rm rmi rmv
rm:
	docker rm $(CONTAINERS) -f
rmi:
	docker rmi $(IMAGES) -f
rmv:
	docker volume rm $(VOLUMES) -f
#	rm -rfd $(HOME)/data/wordpress/*
#	rm -rfd $(HOME)/data/mariadb/*
init_docker:
	@sudo systemctl start docker
	@sudo systemctl start docker-compose

clean:
	docker system prune -a

print:
	@echo "Variable IMAGES= "$(IMAGES)
	@echo "Variable CONTAINERS =" $(CONTAINERS)
	@echo "Variable VOLUMES =" $(VOLUMES)
	#$(foreach CONTAINER,$(CONTAINERS),docker logs $(CONTAINER);)

debug:
	docker exec -it $(shell docker ps -aq) /bin/bash
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
	@echo "debug       :Docker exec -it (container) /bin/bash"

.PHONY: up down start stop stat rma rm rmi rmv init_docker print debug help re
