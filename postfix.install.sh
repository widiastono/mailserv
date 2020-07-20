#!/bin/bash
source config.sh 

### installing postfix 
apt-get install -y postfix postfix-mysql dovecot-core dovecot-pop3d dovecot-imapd dovecot-mysql dovecot-sieve dovecot-managesieved bcrypt certbot python3-certbot-nginx

### configure ssl cert & key from letsencrypt
sudo certbot --nginx --agree-tos --redirect --hsts --staple-ocsp --email $EMAIL_PIC -d $FQDN

