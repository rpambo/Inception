FROM debian:buster

RUN apt update; \
    apt install -y nginx openssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \ 
    -keyout /etc/ssl/private/rpambo.key \
    -out /etc/ssl/certs/rpambo.crt \
    -subj="/C=MA/ST=Luanda/L=Luanda/O=Luanda School/OU=rpambo/CN=rpambo.42.fr"

COPY ./tools/certificate.sh /tmp/certificate.sh

RUN chmod +x /tmp/certificate.sh

COPY ./conf/default /etc/nginx/sites-available/default

ENTRYPOINT ["/tmp/certificate.sh"]
