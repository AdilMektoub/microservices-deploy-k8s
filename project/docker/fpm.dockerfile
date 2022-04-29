FROM php:7.4-fpm
COPY . .
RUN chmod -R 777 ./storage
RUN apt-get update \
    && docker-php-ext-install pdo pdo_mysql
