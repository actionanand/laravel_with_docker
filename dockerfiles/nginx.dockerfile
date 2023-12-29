FROM nginx:1.24.0-alpine

WORKDIR /etc/nginx/conf.d

COPY nginx/nginx.conf .
# `.` means `WORKDIR` (current folder)

RUN mv nginx.conf default.conf
# renaming `default.conf`, as nginx will expect this name

WORKDIR /var/www/html

COPY src .
# copying done for deployment as `bind mount` can't be used in prod.
# comment out the `volumes` in `nginx` and `php` before deployment
