FROM php:8.3.1-fpm-alpine 
# php:7.4-fpm-alpine

WORKDIR /var/www/html

COPY src .
# copying done for deployment as `bind mount` can't be used in prod.

RUN docker-php-ext-install pdo pdo_mysql

# if `cmd` or `entrpoint` not found, it'll be take from base image

RUN chown -R www-data:www-data /var/www/html
# this line is added, if read/write error comes after `COPY` command was added
# `www-data` is the default user created by `php` automatically
# we are gtanting access for this user
