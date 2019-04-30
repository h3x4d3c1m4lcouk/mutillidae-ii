#!/bin/bash
if [ ! -f "/code/startup-completed" ]; then
    service mysql start 
    service php7.2-fpm start
    service nginx start
    mysql -u root -s < /code/resetdb.sql 
    touch /code/startup-completed
    cd /var/www/html/
    php /var/www/html/set-up-database.php
    tail -f /dev/null
else
    service mysql start 
    service php7.2-fpm start
    service nginx start
    tail -f /dev/null
fi