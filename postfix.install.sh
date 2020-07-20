#!/bin/bash
source config.sh 

### installing postfix 
apt-get install -y postfix postfix-mysql dovecot-core dovecot-pop3d dovecot-imapd dovecot-mysql dovecot-sieve dovecot-managesieved bcrypt

#configure postfix 
cp /etc/postfix/main.cf /etc/postfix/main.cf.orig
cp /etc/postfix/master.cf /etc/postfix/master.cf.orig

cp postfix/main.cf /etc/postfix/main.cf
sudo sed -i 's/subdomain.example.com/'$FQDN'/' /etc/postfix/main.cf

groupadd -g 2000 vmail
useradd -g vmail -u 2000 vmail -d /var/vmail -m

cp -rpv dovecot/* /etc/dovecot/
chgrp vmail /etc/dovecot/dovecot.conf
chmod g+r /etc/dovecot/dovecot.conf
/etc/init.d/dovecot restart
chown vmail.vmail /var/log/dovecot-deliver.log
chown root:root /etc/dovecot/dovecot-sql.conf
chmod go= /etc/dovecot/dovecot-sql.conf

### Vimbadmin install
cd /var/www/html/

git clone https://github.com/opensolutions/ViMbAdmin.git 
cp -rpv ViMbAdmin/* $FQDN_ADMIN/
cd /var/www/html/$FQDN_ADMIN
sudo -u www-data composer install --prefer-dist --no-dev

chown -R www-data:www-data /var/www/html/$FQDN_ADMIN
cp /var/www/html/$FQDN_ADMIN/public/.htaccess.dist /var/www/html/$FQDN_ADMIN/public/.htaccess

mysql -u root -e "GRANT ALL PRIVILEGES ON $MAIL_DB.* TO $MAIL_USER@localhost IDENTIFIED BY '$MAIL_PASS'; 
    FLUSH PRIVILEGES;
    CREATE DATABASE IF NOT EXISTS $MAIL_DB;"

cp /var/www/html/$FQDN_ADMIN/application/configs/application.ini.dist /var/www/html/$FQDN_ADMIN/application/configs/application.ini

sudo sed -i  "s/resources.doctrine2.connection.options.driver.*$/resources.doctrine2.connection.options.driver='pdo_mysql'/"  /var/www/html/$FQDN_ADMIN/application/configs/application.ini
sudo sed -i  "s/resources.doctrine2.connection.options.dbname.*$/resources.doctrine2.connection.options.dbname='"$MAIL_DB"'/"  /var/www/html/$FQDN_ADMIN/application/configs/application.ini
sudo sed -i  "s/resources.doctrine2.connection.options.user.*$/resources.doctrine2.connection.options.user='"$MAIL_USER"'/"  /var/www/html/$FQDN_ADMIN/application/configs/application.ini
sudo sed -i  "s/resources.doctrine2.connection.options.password.*$/resources.doctrine2.connection.options.password='"$MAIL_PASS"'/"  /var/www/html/$FQDN_ADMIN/application/configs/application.ini
sudo sed -i  "s/resources.doctrine2.connection.options.host.*$/resources.doctrine2.connection.options.host='localhost'/"  /var/www/html/$FQDN_ADMIN/application/configs/application.ini

cd /var/www/html/$FQDN_ADMIN
./bin/doctrine2-cli.php orm:schema-tool:create