#!/bin/bash

FTP_PASSWORD=$(cat /run/secrets/ftp_pass)

# Verificar se as variáveis de ambiente foram passadas
if [ -z "$FTP_USER" ] || [ -z "$FTP_PASSWORD" ]; then
  echo "Por favor, defina as variáveis de ambiente FTP_USER e FTP_PASSWORD no arquivo .env ou com 'docker run'."
  exit 1
fi

# Criar o usuário FTP com o diretório /var/www/html
useradd -m -d /var/www/html -s /bin/bash $FTP_USER

# Definir a senha do usuário FTP
echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

# Iniciar o serviço vsftpd com a configuração personalizada
vsftpd /etc/vsftpd.conf
