FROM php:8.1-apache
RUN apt-get update &&  apt-get install -y php7.4-mysql 7.4.33-1+deb11u1 && apt-get install -y php-mysqli
COPY ./script /var/www/html
