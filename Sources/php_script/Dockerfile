FROM php:8.1-apache
RUN apt-get update &&  apt-get upgrade -y
RUN docker-php-ext-install mysqli
RUN apt-get install phpmyadmin php-mbstring php-zip php-gd php-json php-curl -y
RUN phpenmod mbstring && systemctl restart apache2
COPY ./script /var/www/html
