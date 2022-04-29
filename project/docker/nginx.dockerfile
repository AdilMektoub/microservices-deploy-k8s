FROM nginx
COPY . .

ADD docker/conf/vhost.conf /etc/nginx/conf.d/default.conf
RUN chmod -R 777 ./storage
WORKDIR /var/www/html
