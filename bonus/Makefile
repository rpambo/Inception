# Nome do projeto (usado como prefixo para os containers e volumes)
PROJECT_NAME=srcs

# Caminho do docker-compose.yml
COMPOSE_FILE=srcs/docker-compose.yml

# Caminho dos diretórios de volumes no host
DATA_DIR=/home/rpambo/data
MARIADB_DIR=$(DATA_DIR)/mariadb
WORDPRESS_DIR=$(DATA_DIR)/wordpress
NGINX_DIR=$(DATA_DIR)/nginx
REDIS_DIR=$(DATA_DIR)/redis
BACKUPS_DIR=$(DATA_DIR)/backups

# Comando base para o Docker Compose
DOCKER_COMPOSE=sudo docker-compose -f $(COMPOSE_FILE)

# Cria os diretórios de volumes no host, se não existirem
prepare:
	mkdir -p $(MARIADB_DIR) $(WORDPRESS_DIR) $(NGINX_DIR) $(REDIS_DIR)  $(BACKUPS_DIR)
	sudo chmod -R 755 $(DATA_DIR)
	sudo fuser -k 443/tcp || true

# Sobe os containers com os volumes preparados
up: prepare
	$(DOCKER_COMPOSE) up --build

# Para os containers
down:
	$(DOCKER_COMPOSE) down

# Remove os containers e volumes associados
clean:
	$(DOCKER_COMPOSE) down -v
	sudo rm -rf $(DATA_DIR)

# Remove apenas os volumes sem apagar os containers
remove:
	sudo docker volume prune -f
	sudo rm -rf $(DATA_DIR)

# Reinicia os serviços
rebuild: clean up

.PHONY: up down clean prepare rebuild remove-volumes
