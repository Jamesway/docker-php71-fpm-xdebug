FROM php:7.1-fpm-alpine

MAINTAINER James <j@mesway.io>

# change user to www-data, no usermod in alpine yet, need to install it from the community repo
RUN echo http://dl-2.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories \
    && apk update \
    && apk --no-cache add shadow \
    && usermod -u 1000 www-data \
    && apk --no-cache add libmcrypt-dev \
                          libmcrypt \
                          mysql-client \
                          curl \
                          openssh-client \
                          autoconf \
                          g++ \
                          make \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && docker-php-ext-install mcrypt pdo_mysql \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_port=9000" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_handler=dbgp" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_connect_back=0" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.idekey = PHPSTORM" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.default_enable=off" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_host=172.254.254.254" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

USER www-data
