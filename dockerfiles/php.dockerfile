FROM php:8.3.1-fpm-alpine 
# php:7.4-fpm-alpine

WORKDIR /var/www/html

COPY src .
# copying done for deployment as `bind mount` can't be used in prod.

RUN docker-php-ext-install pdo pdo_mysql

# if `cmd` or `entrpoint` not found, it'll be take from base image

RUN chown -R www-data:www-data /var/www/html
# this line is added, if read/write error comes after `COPY` command was added
# ^ `www-data` is the default user created by `php` automatically
# we are gtanting access for this user

# * `docker-php-ext-install`
# It's used in Dockerfile to ensure the required extensions are available in the PHP environment

# * PHP Data Object(`pdo`), is a PHP extension that provides a consistent interface for accessing a database.
# It offers a data-access abstraction layer, which means that the same functions can be used to 
# issue queries and fetch data regardless of the database being used.


# * PHP-FPM (FastCGI Process Manager) is a web tool that speeds up a website's performance. 
# It's a processor for PHP, a common scripting language. 
# A process manager is a program that controls the execution of FastCGI application.

# * Common Gateway Interface (CGI) is a protocol that connects external applications to web servers.

# ^ PHP stands for Hypertext Preprocessor, but was originally called Personal Home Page.
