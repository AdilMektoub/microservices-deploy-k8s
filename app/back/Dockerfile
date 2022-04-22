# stage 1
FROM node:latest AS node
RUN echo "NODE Version:" && node --version
RUN echo "NPM Version:" && npm --version

# stage 2
FROM php:5.6-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    git-core \
    curl \
    build-essential \
    openssl \
    libssl-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev

# Install php-xml php-curl
RUN docker-php-ext-install -j$(nproc) xmlrpc

# Save project in container
COPY . ./app

WORKDIR /app

# Clear cache apt-get clean && rm -rf /var/lib/apt/lists/*

# Before Install composer
# RUN apt-get update && apt-get install -y libmcrypt-dev \
#     mysql-client libmagickwand-dev --no-install-recommends \
#     && pecl install imagick \
#     && docker-php-ext-enable imagick \
# && docker-php-ext-install mcrypt pdo_mysql

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer

# try have node for npm
COPY --from=node_base . .

# Install node for npm
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y nodejs \
    npm

# Install dependance of javascript
RUN npm install

# Install packages for laravel with laravel
RUN ./composer.phar update

CMD [ "php artisan serve" ]
