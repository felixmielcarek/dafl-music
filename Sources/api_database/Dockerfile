FROM php:7.4-cli
RUN apt-get update && apt-get install -y \
    zlib1g-dev \
    libzip-dev \
    unzip
RUN docker-php-ext-install zip 
COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN composer self-update
COPY . /usr/src/daflmusic
WORKDIR /usr/src/daflmusic
RUN composer install
CMD [ "php", "./public/index.php" ]