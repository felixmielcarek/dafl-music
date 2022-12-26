FROM php:7.3-fpm
RUN apt-get update && apt-get install -y libmcrypt-dev \
    mariadb-client libmagickwand-dev --no-install-recommends \
    && docker-php-ext-configure mcrypt \
    && docker-php-ext-install mcrypt \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && docker-php-ext-install mcrypt pdo_mysql
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
COPY ./sources /usr/src/daflmusic
WORKDIR /usr/src/daflmusic
RUN php composer.phar require slim/slim:3.*
CMD [ "php", "./public/index.php" ]*