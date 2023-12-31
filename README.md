# Laravel with Docker (Section 6)

Creating laravel project without installing anything in host machine with the help of docker.

![image](https://github.com/actionanand/docker_playground/assets/46064269/3436131f-21ad-4ef4-8f9a-812e22f34b7f)

### Application Containers

* `src`: some folder, on our host machine, contains source code of this laravel php app.
* php Interpreter (`php` service in our code) container: The `src` folder will be exposed to this. This will interpret the php code (src) code and generate response to the incoming request.
* `nginx`: This web server will take all incoming request. And go to php Interpreter & let php interpreter generate response.And send back to the client.
* `sql`: For storing DB. php Interpreter, in the end, needs to communicate with sql.
* Application Conatiners need to be up always.

### Utility Containers

* `Composer`: Composer to php is like what is `npm` to node. This is a package manager which we can use to install third party packages. We'll use composer to create laravel application. And laravel will use composer to install third party dependencies.
* `Laravel Artisan`: Laravel ships its own tool, `Artisan` along with php. This is for run migration against the DB and to write initial data to db.
* `npm`: Laravel uses `npm` for some frontend logics.

## Creating A Laravel Project

[Creating A Laravel Project - Guide](https://laravel.com/docs/10.x#creating-a-laravel-project)

```bash
docker-compose run --rm composer create-project laravel/laravel .
```

* `.` referes to the current folder. So files will be generated in current folder.
* The above command will generate laravel code in `src` folder of our host machine.

![image](https://github.com/actionanand/docker_playground/assets/46064269/33245990-c426-481e-b235-d295cabd695b)

![image](https://github.com/actionanand/docker_playground/assets/46064269/aa7fda0b-6861-40e8-a0c5-796376fc96bd)

* Change the `DB_HOST` value as `mysql` in side the `.env`, found inside `src` folder as for inter-docker communication, if all the containers are under same network, we can replcae `localhost` by `container_name` (here `service_name` as we use `docker-compose`). And change the username, password and database name too as shown below. These values we can find under `env/mysql.env`.

![image](https://github.com/actionanand/docker_playground/assets/46064269/10e24b78-f78e-4b10-9265-349fc6c2e8b9)

## Bringing up the laravel project 

```shell
docker-compose up -d service1 service2 service3 etc
```

```bash
docker-compose up -d server php mysql
```

* If we added `depends_on` property under the service `server` with `php` and `mysql` in `docker-compose.yaml`, the command to bring up the services is as follow:

```bash
docker-compose up -d --build server
```
* `--build` is to rebuild everytime whenever we run the above command, or cached image only will be taken.

![image](https://github.com/actionanand/docker_playground/assets/46064269/344868c8-3c48-428b-9e75-7ee00ca7a34a)
![image](https://github.com/actionanand/docker_playground/assets/46064269/13432b23-5fed-4354-88f4-ba548b2250dd)

### Other userful info.

* Running containers

 ![image](https://github.com/actionanand/docker_playground/assets/46064269/6c8b89db-ab1a-498c-881c-63b4f8920895)

* Built/pulled Images

 ![image](https://github.com/actionanand/docker_playground/assets/46064269/c69169ce-34df-4934-9d80-e1f3f474756b)

 * Generated networks

 ![image](https://github.com/actionanand/docker_playground/assets/46064269/1cd217ad-4442-465c-a4b3-cebbe3a810d4)

### Output

* Point your browser to `localhost:8000`

![image](https://github.com/actionanand/docker_playground/assets/46064269/c96aaded-92c6-4f1c-81bf-359e05be7850)

### Bringing down the docker services

```shell
docker-compose down
```

![image](https://github.com/actionanand/docker_playground/assets/46064269/d2b769a4-d27b-4396-92a3-5337258ae230)

### Checking the db connection and running migrations

![image](https://github.com/actionanand/docker_playground/assets/46064269/a046c7c4-1a52-4285-b7c1-9040ec320365)

### Fixing error if happens

When using Docker on Linux, you might face permission errors when adding a bind mount.
If you happens, try these steps:

* Change the `php.dockerfile` so that it looks like that:

```dockerfile
FROM php:8.3.1-fpm-alpine
 
WORKDIR /var/www/html
 
COPY src .
 
RUN docker-php-ext-install pdo pdo_mysql
 
RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel
 
USER laravel
```

* Please note that the `RUN chown` instruction was removed here, instead we now create a user **laravel** which we use (with the `USER` instruction for commands executed inside of this image / container).

* Also edit the `composer.dockerfile` to look like this:

```dockerfile
FROM composer:2.6.6
 
RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel
 
USER laravel
 
WORKDIR /var/www/html
 
ENTRYPOINT [ "composer", "--ignore-platform-reqs" ]
```

* Here, we add that same **laravel** user and use it for creating the project therefore.

* These steps should ensure that all files which are created by the Composer container are assigned to a user named **laravel** which exists in all containers which have to work on the files.

* Resolving permision issue

```dockerfile
RUN chown -R www-data:www-data /var/www
RUN chmod 755 /var/www
```

## Associated repos:

1. [Docker Basics](https://github.com/actionanand/docker_playground)
2. [Managing Data and working with volumes](https://github.com/actionanand/docker_data_volume)
3. [Docker Communication](https://github.com/actionanand/docker_communication)
4. [Docker Multi-container with docker-compose](https://github.com/actionanand/docker_multi-container)
5. [Docker Utility Containers & Executing Commands](https://github.com/actionanand/node-util)
6. [Laravel with Docker](https://github.com/actionanand/laravel_with_docker)

angular

![image](https://github.com/actionanand/laravel_with_docker/assets/46064269/7510a83c-cafb-4b17-9e3d-179d704f2831)

![image](https://github.com/actionanand/laravel_with_docker/assets/46064269/555411d5-86de-42b5-88c3-a078adc192cf)

![image](https://github.com/actionanand/laravel_with_docker/assets/46064269/f0d40549-7809-487e-b64e-e645441174ec)





