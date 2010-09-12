#!/bin/bash

##
# run in /etc/rc.d/rc.local file.

## ruijie nat ...
# ifconfig eth0 hw ether 00:1E:90:13:e0:25
    # ifconfig eth2 hw ether 00:1B:38:A1:8C:B9
    # service network restart
    # ifconfig virbr0 down
    # mentohust -b3
    # # /usr/local/nat/nat.sh
    # /usr/local/nat/killgxrj.sh&

#ifconfig eth0 hw ether 00:1f:c6:11:ea:90 # ljx
ifconfig eth2 hw ether 00:1b:38:a1:8c:b9 # gx
service network restart
ifconfig virbr0 down
mentohust -b3
iptables -F
/usr/local/nat/nat.sh
#/usr/local/nat/killgxrj.sh&


## for VM's routeing
route add -net 172.18.13.0/24 gw 10.3.1.29

## for IPv6
ifconfig eth0 add 2001:250:1800:1::4/64   #ipv6 地址
route -A inet6 add default gw 2001:250:1800:1::29 #ipv6 网关

## for svnserve
svnserve -d -r /var/svn
