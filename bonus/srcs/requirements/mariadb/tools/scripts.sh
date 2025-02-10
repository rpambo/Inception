#!/bin/bash
set -e

# Verificar se o diretório de dados do MySQL está vazio
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Inicializando o banco de dados..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# Corrigir permissões antes de iniciar o MySQL
chown -R mysql:mysql /var/lib/mysql

# Iniciar o servidor MySQL corretamente
echo "Iniciando o MySQL..."
mysqld_safe --datadir=/var/lib/mysql &

# Função para aguardar MySQL estar pronto
wait_for_mysql() {
    echo "Aguardando o servidor MySQL estar pronto..."
    while ! mysqladmin ping -hlocalhost --silent; do
        sleep 2
    done
    echo "Servidor MySQL está pronto."
}

wait_for_mysql

MYSQL_PASSWORD=$(cat /run/secrets/db_password)

mysql -u${MYSQL_ROOT_USER} -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"

mysql -u${MYSQL_ROOT_USER} -p${MYSQL_ROOT_PASSWORD} -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mysql -u${MYSQL_ROOT_USER} -p${MYSQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"

mysql -u${MYSQL_ROOT_USER} -p${MYSQL_ROOT_PASSWORD} -e "ALTER USER '${MYSQL_ROOT_USER}'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"

mysql -u${MYSQL_ROOT_USER} -p${MYSQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

wait