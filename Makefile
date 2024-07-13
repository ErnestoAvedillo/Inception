all:	up

IMAGES = $$(docker images -aq)
CONTAINERS= $$(docker ps -aq)
VOLUMES= $$(docker volume ls -q)

up:
	docker-compose -f ./docker-compose.yaml up -d --build

down:
	docker-compose -f docker-compose.yaml down

start:
	docker-compose -f docker-compose.yaml start

stop:
	docker-compose -f docker-compose.yaml stop

status : 
	@echo "-------docker ps---------"
	@docker ps -a
	@echo "-------images---------"
	@docker images -a
	@echo "-------volumes---------"
	@docker volume ls

rm:
	docker rm $(CONTAINERS) -f

rmi:
	docker rmi $(IMAGES) -f
rmv:
	docker volume rm $(VOLUMES) -f
init_docker:
	@sudo systemctl start docker
	@sudo systemctl start docker-compose

print:
	@echo "Variable IMAGES= "$(IMAGES)
	@echo "Variable CONTAINERS =" $(CONTAINERS)
	@echo "Variable VOLUMES =" $(VOLUMES)

debug:
	docker exec -it $(shell docker ps -aq) /bin/bash

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
