FROM php:7.4-fpm
RUN apt-get update \
    && docker-php-ext-install pdo pdo_mysql
ADD . /var/www
RUN chown -R www-data:www-data /var/www
WORKDIR /var/www


# FROM php:7-fpm
# WORKDIR /var/www
# RUN apt-get update && apt-get install -y libmcrypt-dev mysql-client && docker-php-ext-install mcrypt pdo_mysql
# ADD . /var/www
# RUN chown -R www-data:www-data /var/www
