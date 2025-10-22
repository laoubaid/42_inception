
COMPOSE_FILE=srcs/docker-compose.yml
DATA_DIR=/home/laoubaid/data

all:
	@docker compose -f $(COMPOSE_FILE) up -d

down:
	@docker compose -f $(COMPOSE_FILE) down

vols:
	@docker compose -f $(COMPOSE_FILE) volumes

ps:
	@docker compose -f $(COMPOSE_FILE) ps

images:
	@docker compose -f $(COMPOSE_FILE) images

logs:
	@docker compose -f $(COMPOSE_FILE) logs

clean: down
	@docker volume rm -f srcs_incp_database srcs_incp_wordpress

fclean: clean
	sudo rm -rf $(DATA_DIR)/database/*
	sudo rm -rf $(DATA_DIR)/wordpress/*
	sudo rm -rf $(DATA_DIR)/nginx/*
	@docker compose -f $(COMPOSE_FILE) down --rmi all --volumes

re: fclean all

.PHONY: all
