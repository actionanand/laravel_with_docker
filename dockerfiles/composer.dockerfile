FROM composer:2.6.6

WORKDIR /var/www/html

ENTRYPOINT [ "composer", "--ignore-platform-reqs" ]

# * Sometimes when using `composer install` or `composer update` commands you might install packages 
# that don't fulfill system requirements, something like "your php version (8.1. 2) does not satisfy 
# ^ that requirement". To ignore these requirements you can use the flag `--ignore-platform-reqs`
