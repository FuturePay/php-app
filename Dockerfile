FROM php:7.1.4-apache

COPY assets/* /tmp/

# Install pdo
RUN docker-php-ext-install pdo_mysql

# Enable mod_rewrite
RUN a2enmod rewrite

# Install confd
RUN curl -Lo /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 && \
    chmod +x /usr/local/bin/confd && \
    mkdir -p /etc/confd/templates && \
    mkdir -p /etc/confd/conf.d

# Install entrypoint
RUN mv /tmp/entrypoint /usr/local/bin/

# Cleanup
RUN rm -r /tmp/*

ENTRYPOINT ["entrypoint"]
CMD ["apache2-foreground"]
