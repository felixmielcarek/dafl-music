FROM php:7.3-fpm
RUN apt-get update && apt-get install -y libmcrypt-dev \
    mariadb-client libmagickwand-dev --no-install-recommends \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
&& docker-php-ext-install mcrypt pdo_mysql
RUN docker-php-ext-configure mcrypt
RUN docker-php-ext-install mcrypt
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN php composer.phar require slim/slim:3.*
COPY . /usr/src/daflmusic
WORKDIR /usr/src/daflmusic
CMD [ "php", "./public/index.php" ]*