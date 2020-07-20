### install mariadb-server
apt install -y mariadb-server

### install PHP7.3 & NGiNX
### Maraidb install
sudo apt install -y maridb-server
sudo mysql_secure_install

### PHP 
# install
sudo apt install -y php7.3 php7.3-bcmath php7.3-bz2 php7.3-cgi php7.3-cli php7.3-common php7.3-curl \
    php7.3-dba php7.3-enchant php7.3-fpm php7.3-gd php7.3-gmp php7.3-imap php7.3-interbase php7.3-intl \
    php7.3-json php7.3-ldap php7.3-mbstring php7.3-mysql php7.3-opcache php7.3-phpdbg php7.3-pspell \
    php7.3-readline php7.3-recode php7.3-snmp php7.3-sqlite3 php7.3-sybase php7.3-tidy php7.3-xml \
    php7.3-xmlrpc php7.3-xsl php7.3-zip 

# config 
sudo cp /etc/php/7.3/fpm/pool.d/www.conf /etc/php/7.3/fpm/pool.d/$SUBDOMAIN.conf
sudo sed -i 's/\[www\]/\['$SUBDOMAIN'\]/' /etc/php/7.3/fpm/pool.d/$SUBDOMAIN.conf
sudo sed -i 's/php7.3-fpm.sock/php7.3-fpm_'$SUBDOMAIN'.sock/' /etc/php/7.3/fpm/pool.d/$SUBDOMAIN.conf 

sudo service php7.3-fpm restart 

### NGiNX
sudo apt install -y nginx
sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.orig
sudo cp default /etc/nginx/sites-available/default
sudo sed -i 's/server_name _/server_name '$FQDN'/' /etc/nginx/sites-available/default
sudo sed -i 's/php7.3-fpm.sock/php7.3-fpm_'$SUBDOMAIN'.sock/' /etc/nginx/sites-available/default
sudo sed -i 's/root \/var\/www\/html;/root \/var\/www\/html\/'$FQDN';' /etc/nginx/sites-available/default
mkdir /var/www/html/$FQDN 
echo "<?php phpinfo(); ?>" > /var/www/html/$FQDN/info.php
chown -R www-data:www-data /var/www/html/$FQDN

sudo service nginx restart

