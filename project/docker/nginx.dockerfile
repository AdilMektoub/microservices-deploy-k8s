FROM nginx
ADD docker/conf/vhost.conf /etc/nginx/conf.d/default.conf
WORKDIR /var/www/html
ADD . /var/www
RUN chown -R www-data:www-data /var/www
RUN chmod -R 777 /var/www/*
RUN ["chmod", "-R", "777", "*"]
