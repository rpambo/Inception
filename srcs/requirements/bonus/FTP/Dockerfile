# Usando a imagem base Debian
FROM debian:buster

# Definir variáveis de ambiente para não interatividade
ENV DEBIAN_FRONTEND=noninteractive

# Instalar pacotes necessários (vsftpd)
RUN apt-get update && apt-get install -y \
    vsftpd \
    ftp \
    && rm -rf /var/lib/apt/lists/*

# Criar o diretório seguro chroot para vsftpd
RUN mkdir -p /var/run/vsftpd/empty && chmod 755 /var/run/vsftpd/empty

# Copiar o arquivo de configuração para o contêiner
COPY /conf/vsftpd.conf /etc/vsftpd.conf

# Copiar o script para configurar o FTP
COPY /tools/setup_ftp.sh /usr/local/bin/setup_ftp.sh

# Garantir que o script seja executável
RUN chmod +x /usr/local/bin/setup_ftp.sh

# Expor a porta 21 para o FTP
EXPOSE 21

# Rodar o script de configuração do FTP
ENTRYPOINT ["/usr/local/bin/setup_ftp.sh"]
