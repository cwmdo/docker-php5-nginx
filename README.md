Just another docker PHP (spaghetti) Stack
=================

This is a tuned PHP stack compatible with the Twelve-Factor methodology built on nginx, php-fpm and postfix. It's configured with performance in mind and settings have been tweaked to suit production deployments. In accordance to the Twelve-Factor methodology it uses environment variables to connect to a database (postgres, mariadb, etc) by simply linking a database to this container and using environment variables to pass login information. It also uses postfix which can be configured to use an external SMTP service (mailgun, mandrill, etc) through environment variables.

You can read more about the Twelve-Factor methodology here: http://12factor.net

You can grab the accompanying database container here: https://github.com/heyimwill/docker-mariadb

## Features
* Installs nginx, php-fpm and postfix
* Tuned nginx & php configurations
* h5bp security & speed enhancements (https://github.com/h5bp/server-configs-nginx)
* Tuned sysctl.conf
* Support for external SMTP service (e.g http://mandrillapp.com)
* Easily access logs
* Compatible with the Twelve Factor Methodology (http://12factor.net)

## Running
In order for this container to run at all, these environment variables need to be defined: SMTP_HOST, SMTP_USER, SMTP_PASS, DB_USER and DB_PASS. It also needs to be linked to a database container with an alias defined as ```db```.

It expects you to mount your web root to ```/var/www```. If you want easy access to logs, you can mount ```/logs``` as well.

It all comes out to something like this:
```
docker run -d --link mariadb:db -v /home/deploy/www:/var/www -e -v /home/deploy/logs/php-stack:/logs "SMTP_HOST=smtp.mandrillapp.com:587" -e "SMTP_USER=username" -e "SMTP_PASS=pass" -e "DB_USER=db username" -e "DB_PASS=db pass" heyimwill/docker-php5-nginx
```

## Database
This container is supposed to run side by side with a database container, so make sure you link this container with a database container assigned the alias ```db```. Here's how it can be used to conigure your app to connect to your database:
```
# Sets the database hostname
$db_host = $_SERVER["DB_ADDR"];

# Sets the database port
$db_port = $_SERVER["DB_PORT"];

# Sets the username
$db_user = $_SERVER["DB_USER"];

# Sets the password
$db_password = $_SERVER["DB_PASS"];
```

If you don't want to roll your own database container, here's a prebuilt MariaDB (MySQL) container that works great with this one: https://github.com/heyimwill/docker-mariadb

