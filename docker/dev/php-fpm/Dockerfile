FROM php:8.2-fpm-alpine

RUN apk add --no-cache linux-headers autoconf g++ make \
    && pecl install xdebug \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable xdebug

RUN mv $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini

COPY ./common/php/conf.d /usr/local/etc/php/conf.d
COPY ./dev/php/conf.d /usr/local/etc/php/conf.d
COPY ./dev/php-fpm/conf.d /usr/local/etc/php/conf.d

WORKDIR /app
