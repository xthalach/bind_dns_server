#!/bin/bash
echo -e "search informatica.com asix2.informatica.com dam2.informatica.com\nnameserver 192.168.76.1" > /etc/resolvconf/resolf.conf.d/head
cd /etc/bind
rm -rf named.conf.options && wget https://raw.githubusercontent.com/xthalach/DNS-DHCP/main/named.conf.options
rm -rf named.conf.local && wget https://raw.githubusercontent.com/xthalach/DNS-DHCP/main/named.conf.local
wget https://raw.githubusercontent.com/xthalach/DNS-DHCP/main/db.informatica.hosts 
wget https://raw.githubusercontent.com/xthalach/DNS-DHCP/main/192.168.rev
mkdir asix2 && cd asix2
wget https://raw.githubusercontent.com/xthalach/DNS-DHCP/main/db.asix2.hosts
wget https://raw.githubusercontent.com/xthalach/DNS-DHCP/main/192.168.76.rev
cd .. && mkdir dam2 && cd dam2
wget https://raw.githubusercontent.com/xthalach/DNS-DHCP/main/db.dam2.hosts
wget https://raw.githubusercontent.com/xthalach/DNS-DHCP/main/192.168.176.rev

cd /etc/dhcp/
mv dhcpd.conf dhcpd.conf.bak && wget https://raw.githubusercontent.com/xthalach/DNS-DHCP/main/dhcpd.conf

cd /usr/sbin/
wget https://raw.githubusercontent.com/xthalach/DNS-DHCP/main/activar_enrutament.sh
wget https://raw.githubusercontent.com/xthalach/DNS-DHCP/main/desactivar_enrutament.sh
chmod +x activar_enrutament.sh desactivar_enrutament.sh

cd /etc/init.d/
wget https://raw.githubusercontent.com/xthalach/DNS-DHCP/main/enrutament
chmod +x enrutament
/etc/init.d/enrutament start

service bind9 restart
netplan apply

