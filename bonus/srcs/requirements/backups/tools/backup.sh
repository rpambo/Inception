#!/bin/bash

# Configurações do Banco de Dados
MYSQL_HOST="${MYSQL_HOST}"
MYSQL_USER="${MYSQL_USER}"
MYSQL_PASSWORD=$(cat /run/secrets/db_password)
MYSQL_DATABASE="${MYSQL_DATABASE}"
BACKUP_DIR="/backups"

# Data e Hora para nome do arquivo de backup
DATE=$(date +\%Y\%m\%d_\%H\%M)

# Nome do arquivo de backup
BACKUP_FILE="${BACKUP_DIR}/backup_${DATE}.sql"

# Iniciar o Backup
echo "Iniciando o backup do banco de dados ${MYSQL_DATABASE}..."

# Comando mysqldump para realizar o backup
mysqldump -h "${MYSQL_HOST}" -u "${MYSQL_USER}" -p"${MYSQL_PASSWORD}" "${MYSQL_DATABASE}" > "${BACKUP_FILE}"

# Verificar se o backup foi bem-sucedido
if [ $? -eq 0 ]; then
    echo "Backup criado com sucesso: ${BACKUP_FILE}"
else
    echo "Erro ao criar o backup!"
fi

