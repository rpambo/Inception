FROM debian:buster

# Atualizar e instalar cron e default-mysql-client (cliente MySQL)
RUN apt-get update && apt-get install -y cron default-mysql-client

# Criar diretório para armazenar os backups e garantir permissões corretas
RUN mkdir -p /backups && chmod 777 /backups

# Copiar o script de backup para o contêiner
COPY ./tools/backup.sh /usr/local/bin/backup.sh

# Dar permissão para o script de backup
RUN chmod +x /usr/local/bin/backup.sh

# Criar um cron job que execute o backup a cada minuto
RUN echo "* * * * * root /usr/local/bin/backup.sh >> /var/log/backup.log 2>&1" > /etc/cron.d/backup-cron

# Definir permissões corretas para o cron job
RUN chmod 0644 /etc/cron.d/backup-cron

# Criar o arquivo de log, se necessário
RUN touch /var/log/backup.log

# Iniciar o cron como um processo em primeiro plano
CMD ["cron", "-f"]



