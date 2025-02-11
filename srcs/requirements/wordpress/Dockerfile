FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    php-fpm \
    php-mysql \
    php-zip \
    curl \
    vim \
    sendmail && \
    mkdir -p /run/php

COPY conf/www.conf  /etc/php/8.3/fpm/pool.d/www.conf

WORKDIR /var/www/html
RUN chown -R www-data:www-data /var/www/html
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY ./tools/scripts.sh /tools/scripts.sh

RUN chmod +x /tools/scripts.sh

ENTRYPOINT ["/tools/scripts.sh"]

