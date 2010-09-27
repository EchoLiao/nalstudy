#!/bin/bash

# DES: 由于网线的原因, 需要不断地重起锐捷

rjIP="10.3.10.254"
rjMAC="00:d0:f8:f5:ff:4a" # 真正的锐捷端MAC地址

while [ 1 ]; do
    # 用arp命令查看并取得当前所能识别的锐捷服务端地址
    rjMAC_curr=`arp -n | grep "$rjIP" | awk '{print $3}'`
    if [[ "$rjMAC_curr" != "$rjMAC" ]]; then
        echo "restart ruijie:"
        mentohust -k
        usleep 50000
        mentohust -b3
        sleep 1
    else
        echo "had connected, ruijie MAC: $rjMAC_curr"
    fi

    sleep 2
done
