COMPOSE_FILE=./srcs/docker-compose.yml

all: up

up:
	mkdir -p ~/data/wordpress
	mkdir -p ~/data/mariadb
	docker compose -f $(COMPOSE_FILE) up -d --build

stop:
	docker compose -f $(COMPOSE_FILE) stop

down:
	docker compose -f $(COMPOSE_FILE) down
build:
	docker compose -f $(COMPOSE_FILE) build

clean: down
	docker system prune -a -f
	docker volume prune -a -f
	docker image prune -f
	docker network prune -f

fclean: clean
	sudo rm -fr $(HOME)/data

re: fclean all

.PHONY: up down stop build