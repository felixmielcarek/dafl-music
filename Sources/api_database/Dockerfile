FROM php:7.4-cli
RUN apt-get update && apt-get install -y libmcrypt-dev mariadb-client libmagickwand-dev unzip git --no-install-recommends
RUN pecl install imagick 
RUN docker-php-ext-enable imagick 
RUN docker-php-ext-install pdo_mysql
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
COPY . /usr/src/daflmusic
WORKDIR /usr/src/daflmusic
RUN ls
RUN php /usr/local/bin/composer require slim/slim:3.*
RUN ls
CMD [ "php", "./public/index.php" ]