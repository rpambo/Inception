# Nome do projeto (prefixo para containers e volumes)
PROJECT_NAME=inception

# Caminhos dos arquivos docker-compose
COMPOSE_FILE=srcs/docker-compose.yml
COMPOSE_FILE_BONUS=srcs/requirements/bonus/docker-compose.bonus.yml

# Diretórios de volumes no host
DATA_DIR=/home/rpambo/data
MARIADB_DIR=$(DATA_DIR)/mariadb
WORDPRESS_DIR=$(DATA_DIR)/wordpress
NGINX_DIR=$(DATA_DIR)/nginx
BACKUP_DIR=$(DATA_DIR)/backups
REDIS_DIR=$(DATA_DIR)/redis

# Comando base para Docker Compose
DOCKER_COMPOSE=sudo docker-compose -f $(COMPOSE_FILE)
DOCKER_COMPOSE_BONUS=sudo docker-compose -f $(COMPOSE_FILE_BONUS)

# Criação de volumes e permissões para o mandatório
prepare:
	mkdir -p $(MARIADB_DIR) $(WORDPRESS_DIR) $(NGINX_DIR)
	sudo chmod -R 755 $(DATA_DIR)
	sudo fuser -k 443/tcp || true

# Criação de volumes e permissões para o bônus
prepare_bonus:
	mkdir -p $(MARIADB_DIR) $(WORDPRESS_DIR) $(NGINX_DIR) $(BACKUP_DIR) $(REDIS_DIR)
	sudo chmod -R 755 $(DATA_DIR)
	sudo fuser -k 443/tcp || true

# Sobe os containers do mandatório
up: clean_bonus prepare
	$(DOCKER_COMPOSE)  up --build

# Sobe os containers do bônus
bonus: clean_mandatory prepare_bonus
	$(DOCKER_COMPOSE_BONUS) --env-file ./srcs/.env up --build

# Remove os containers e volumes do mandatório
clean_mandatory:
	@echo "Limpando ambiente do Mandatório..."
	$(DOCKER_COMPOSE) down -v
	sudo rm -rf $(DATA_DIR)

# Remove os containers e volumes do bônus
clean_bonus:
	@echo "Limpando ambiente do Bônus..."
	$(DOCKER_COMPOSE_BONUS) down -v
	sudo rm -rf $(DATA_DIR)

# Remove todos os containers e volumes
clean: clean_mandatory clean_bonus

# Remove apenas os volumes sem apagar os containers
remove_volumes:
	sudo docker system prune --volumes
	sudo docker volume prune -f
	sudo rm -rf $(DATA_DIR)

# Reinicia os serviços do mandatório
rebuild: clean_mandatory up

# Reinicia os serviços do bônus
rebuild_bonus: clean_bonus bonus

.PHONY: up down clean prepare rebuild remove_volumes bonus clean_mandatory clean_bonus prepare_bonus rebuild_bonus
