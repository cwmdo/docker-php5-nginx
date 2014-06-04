Just another docker PHP Stack
=================

This is a tuned PHP stack compatible with the Twelve-Factor methodology including php5, php-fpm and postfix. It's built with performance in mind and settings have been tweaked to suit production deployments. In accordance to the Twelve-Factor methodology it supports environment variables to connect a database (postgres, mariadb, etc) by simply linking this container to your databse container and using environment variables to define a username/password. It also uses postfix which can be configured to use an external SMTP service (mailgun, mandrill, etc) through environment variables.

You can read more about the Twelve-Factor methodology here: http://12factor.net

## Setup
Grab the latest version of this image from the Docker index:
```
docker pull heyimwill/docker-php5-nginx
```
You can also build the image yourself right from this repo:
```
docker build -t php-stack github.com/heyimwill/docker-php5-nginx
```

## Running
In order for this image to run at all, these environment variables need a defined value: SMTP_HOST, SMTP_USER, SMTP_PASS, DB_USER and DB_PASS. It also needs to be linked to a database container with an alias defined as ```db```.

It expects you to mount your web root to ```/var/www```.

Here's how an example of how it can be ran:
```
docker run -d --link mariadb:db -v /home/deploy/www/rechargify-prod:/var/www -e "SMTP_HOST=smtp.mandrillapp.com:587" -e "SMTP_USER=username" -e "SMTP_PASS=pass" -e "DB_USER=username" -e "DB_PASS=pass" php-stack
```

## Database
This container is meant to be ran in tandem with a database container, make sure you link this container to that one using the alias ```db```. This is how you echo the connection details in your PHP App:
```
# Echoes the database hostname
echo $_SERVER["DB_ADDR"];

# Echoes the database port
echo $_SERVER["DB_PORT"];

# Echoes the username
echo $_SERVER["DB_USER"];

# Echoes the password
$_SERVER["DB_ENV_PASS"];
```
If you're looking for a MariaDB container to use, this one works well: https://github.com/heyimwill/docker-mariadb. It's based on Painted-Fox's excellent work.


## Roadmap

