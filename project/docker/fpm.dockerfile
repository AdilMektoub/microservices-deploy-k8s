FROM php:7.4

RUN apt-get update -y && apt-get install -y openssl zip unzip git libonig-dev

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN docker-php-ext-install pdo mbstring sockets mysqli pdo_mysql

WORKDIR /fpm

COPY . /fpm

RUN composer install

# RUN php artisan make:migration create_products_table

# RUN php artisan migrate

CMD php artisan serve --host=0.0.0.0 --port=8000

EXPOSE 8000
