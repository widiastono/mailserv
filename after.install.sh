### update repositories
apt-get update -y

### install needed packaged for daily usage
apt-get install -y net-tools ntp sysstat iptraf traceroute tcptraceroute pktstat bwm-ng whois httperf mailutils lynx \
nast dsniff build-essential tcpdump sudo curl vim dnsutils mailutils

### adding $USER to sudo group
usermod -G sudo $USER

### adding ntp server to ntp client config
if ! grep -q '### ID NTP' /etc/ntp.conf
then
	echo "### ID NTP" >> /etc/ntp.conf
	sed -i '18r ntp-id.conf' /etc/ntp.conf
else
	echo -e "ntp config updated"
fi

### adding localzone
mv /etc/localtime /etc/localtime.old
ln -s /usr/share/zoneinfo/$TIMEZONE /etc/localtime

### setup ssh server
sed -i 's/#Port 22$/Port '$PORT_SSH'/' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin without-password/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config
if ! grep -q 'UseDNS no' /etc/ssh/sshd_config
then
	echo 'UseDNS no' >> /etc/ssh/sshd_config
fi

service ssh restart 

### removing exim4
### disable uneeded services
service exim4 stop
update-rc.d -f exim4 remove
service rpcbind stop
update-rc.d -f rpcbind remove

### remove exim4
apt purge exim4-config exim4-daemon-light

### vim beauty
sh vim.install.sh
sudo -u $USER sh vim.install.sh

