FROM php:8.1-apache
RUN apt-get update &&  apt-get upgrade -y
RUN docker-php-ext-install mysqli
COPY ./script /var/www/html
RUN docker run -d --name phpmyadmin -e PMA_ARBITRARY=1 -p 8080:80 phpmyadmin
