all:	up

IMAGES = $$(docker images -q)

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
	@docker ps
	@echo "-------images---------"
	@docker images 
	@echo "-------volumes---------"
	@docker volume ls

rm:
	@docker volume rm mariadb
	@docker volume rm wordpress

rmi:
	@docker rmi $(IMAGES) -f

init_docker:
	@sudo systemctl start docker

print:
	@echo $(IMAGES)