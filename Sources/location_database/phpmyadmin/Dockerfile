FROM php:8.1-apache
RUN apt-get update &&  apt-get upgrade -y
RUN docker-php-ext-install mysqli
COPY ./phpmyadmin /var/www/html
EXPOSE 80