#!/bin/bash
# Starts up Nginx and PHP within the container.

DATADIR="/var/www"

# Don't continue if we catch an error.
# set -e

# Ensure www-data owns the DATADIR
chown -R www-data $DATADIR

# Echo in environment variables to the PHP-FPM config file
 sed -i "s/DBADDR/$DB_PORT_3306_TCP_PORT/g" /etc/php5/fpm/pool.d/www.conf
 sed -i "s/DBPORT/$DB_PORT_3306_TCP_ADDR/g" /etc/php5/fpm/pool.d/www.conf
 sed -i "s/DBUSER/$DB_ENV_USER/g" /etc/php5/fpm/pool.d/www.conf
 sed -i "s/DBPASS/$DB_ENV_PASS/g" /etc/php5/fpm/pool.d/www.conf

# Echo in environment variables to the postfix config file
sed -i "s/SMTPHOST/$SMTP_HOST/g" /etc/postfix/main.cf
sed -i "s/SMTPHOST/$SMTP_HOST/g" /etc/postfix/sasl/sasl_passwd
sed -i "s/SMTPUSER/$SMTP_USER/g" /etc/postfix/sasl/sasl_passwd
sed -i "s/SMTPPASS/$SMTP_PASS/g" /etc/postfix/sasl/sasl_passwd

# Postmap the Postfix changes
postmap /etc/postfix/sasl/sasl_passwd

echo "Starting nginx..."
service nginx start
service nginx status
echo "Starting PHP5..."
service php5-fpm start
service php5-fpm status
echo "Starting Postfix..."
service postfix start ; service postfix status ; read -p "Hit enter to kill"
