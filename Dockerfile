FROM php:7.1.4-apache

RUN pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && docker-php-ext-install pdo_mysql \
    && a2enmod rewrite \
    && apt-get update -y \
    && apt-get install -y wget \
    && wget -O /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 \
    && chmod +x /usr/local/bin/confd \
    && mkdir -p /etc/confd/templates \
    && mkdir -p /etc/confd/conf.d \
    && rm -r /var/lib/apt/lists/*

COPY apache2-foreground /usr/local/bin/
RUN chmod +x /usr/local/bin/apache2-foreground
COPY xdebug.ini.tmpl /etc/confd/templates/
COPY xdebug.toml /etc/confd/conf.d/

