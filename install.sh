#!/bin/bash
### default Variable
DOMAIN=widiastono.my.id
SUBDOMAIN=mail
FQDN=$SUBDOMAIN.$DOMAIN
USER=widiastono
EMAIL_PIC="widiastono@gmail.com"
TIMEZONE="Asia/Jakarta"
PORT_SSH=22


### after install 
bash after.install.sh

### bind install
bash bind.install.sh

### NGiNX PHP MariaDB install
#sh lemper.install.sh

### mail server install
#sh postfix.install.sh