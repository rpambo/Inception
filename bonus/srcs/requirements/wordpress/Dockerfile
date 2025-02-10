FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    php-fpm \
    php-mysql \
    php-zip \
    php-redis \
    curl \
    vim \
    sendmail \
    redis-server && \
    sed -i -e 's/listen =.*/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf && \
    sed -i -e 's/;listen.owner = www-data/listen.owner = www-data/g' /etc/php/7.3/fpm/pool.d/www.conf && \
    sed -i -e 's/;listen.group = www-data/listen.group = www-data/g' /etc/php/7.3/fpm/pool.d/www.conf && \
    sed -i -e 's/;listen.mode = 0660/listen.mode = 0660/g' /etc/php/7.3/fpm/pool.d/www.conf && \
    sed -i -e 's/;clear_env = no/clear_env = no/g' /etc/php/7.3/fpm/pool.d/www.conf && \
    sed -i -e 's/;catch_workers_output = yes/catch_workers_output = yes/g' /etc/php/7.3/fpm/pool.d/www.conf && \
    mkdir -p /run/php 

WORKDIR /var/www/html
RUN chown -R www-data:www-data /var/www/html
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY ./tools/scripts.sh /tools/scripts.sh

RUN chmod +x /tools/scripts.sh

ENTRYPOINT ["/tools/scripts.sh"]
