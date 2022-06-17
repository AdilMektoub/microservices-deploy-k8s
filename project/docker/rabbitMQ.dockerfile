FROM rabbitmq:3.7-management

COPY docker/conf/rabbitmq/rabbitmq.conf /etc/rabbitmq
COPY docker/conf/rabbitmq/definitions.json /etc/rabbitmq

RUN cat /etc/rabbitmq/rabbitmq.conf
