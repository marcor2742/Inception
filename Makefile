COMPOSE_FILE=./srcs/docker-compose.yml

all: up

up:
	mkdir -p ~/data/wordpress
	mkdir -p ~/data/mariadb
	docker compose -f $(COMPOSE_FILE) up -d --build

stop:
	docker compose -f $(COMPOSE_FILE) stop

down:
	docker compose -f $(COMPOSE_FILE) down -v

build:
	docker compose -f $(COMPOSE_FILE) build

.PHONY: up down stop build