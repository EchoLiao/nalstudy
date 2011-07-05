#!/bin/bash

##
# run in /etc/rc.d/rc.local file.

############################ In gongsi ######################

## for network
service network restart
service iptables stop
service nfs restart

## for svnserve
svn=`ps aux | grep svnserve | grep -v grep`
[[ $svn ]] || svnserve -d -r /var/svn

## mount
mount -t cifs -o nolock //192.168.3.129/rsync /media/win_rsync_dir/ -o username=administrator -o password=hql12345
mount -t cifs -o nolock //192.168.3.129/bk /media/win_bk_dir/ -o username=administrator -o password=hql12345
mount -t cifs -o nolock //192.168.3.129/whxlog /home/log -o username=administrator -o password=hql12345




exit 0
############################ In school ######################
## ruijie nat ...
# ifconfig eth3 hw ether 00:1E:90:13:e0:25
    # ifconfig eth3 hw ether 00:1B:38:A1:8C:B9
    # service network restart
    # ifconfig virbr0 down
    # mentohust -b3
    # # /usr/local/nat/nat.sh
    # /usr/local/nat/killgxrj.sh&

#ifconfig eth3 hw ether 00:1f:c6:11:ea:90 # ljx
#ifconfig eth3 hw ether 00:1b:38:a1:8c:b9 # gx
ifconfig eth3 hw ether 00:22:15:5D:01:51 # yl
service network restart
ifconfig virbr0 down
mentohust -b3
iptables -F
/usr/local/nat/nat.sh
# /usr/local/nat/killgxrj.sh&


## for VM's routeing
route add -net 172.18.13.0/24 gw 10.3.1.29
route del -net 169.254.0.0/16

## for IPv6
ifconfig eth3 add 2001:250:1800:1::4/64   # ipv6 地址
route -A inet6 add default gw 2001:250:1800:1::29 # ipv6 网关

## restart DNS server
service named restart

## 重起锐锐
rj=`ps aux | grep rj_restart.sh | grep -v grep`
if [[ ! $rj ]]; then
    eval /home/scr/bin/rj_restart.sh>/dev/null &
fi

## for svnserve
svn=`ps aux | grep svnserve | grep -v grep`
if [[ ! $svn ]]; then
    svnserve -d -r /var/svn
fi
