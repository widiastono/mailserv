#!/bin/bash
source config.sh 

### install bind9 as dns resolver
apt install -y bind9 
cp bind/named.conf.options /etc/bind/named.conf.options

service bind9 restart
echo "search $DOMAIN" > /etc/resolv.conf
echo "nameserver 127.0.0.1" >> /etc/resolv.conf
sed -i 's/nameservers 175.106.17.254/nameservers 127.0.0.1/' /etc/network/interfaces

