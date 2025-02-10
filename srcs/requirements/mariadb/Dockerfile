FROM debian:buster

# Atualizar e instalar MariaDB
RUN apt-get update -y && apt-get install -y \
    mariadb-server \
    mariadb-client && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copiar arquivos de configuração
COPY ./tools/scripts.sh /usr/local/bin/scripts.sh
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/healthcheck.sh usr/local/bin/healthcheck.sh

RUN chmod +x /usr/local/bin/scripts.sh

# Criar diretório e definir permissões
RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql

# Criar volume para os dados do banco de dados
VOLUME /var/lib/mysql

# Expor porta
EXPOSE 3306

# Definir script de inicialização
ENTRYPOINT ["/usr/local/bin/scripts.sh"]

