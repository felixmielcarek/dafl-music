FROM php:8.1-apache
RUN apt-get update &&  apt-get upgrade -y
RUN docker-php-ext-install mysqli
RUN apt-get install -y phpmyadmin php8.1-mbstring php-gettext -y
COPY ./script /var/www/html
