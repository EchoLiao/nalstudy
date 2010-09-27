#!/bin/bash

export GREP_OPTIONS='--color=always'
export GREP_COLOR='1;32'

gxfile="/usr/local/nat/gxnat.sh"
preflag=0
curflag=0
init=1


/usr/local/nat/nat.sh

while [ 1 -lt 2 ] # run forever
do
    arpmac=`arp -n | grep "10.3.1.44"`
    remac=`echo $arpmac | awk '{print $3}'`

    if [ "$remac" == "00:1b:38:a1:8c:b4" ]; then # xp
	curflag=0   # 180/s
    else
	curflag=1   # 7/s
    fi

    echo "#!/bin/bash" > $gxfile
    if [ $init -eq 1  -o  $curflag -ne $preflag ]; then
	init=0
	date >> /usr/local/nat/log.txt
	if [ $curflag -eq 0 ]; then
	    echo "/sbin/iptables -A FORWARD -s 10.3.1.44 -m limit --limit 160/s -j ACCEPT" >> $gxfile
	    echo "/sbin/iptables -A FORWARD -s 10.3.1.44 -j DROP" >> $gxfile
	    echo "XP" >> /usr/local/nat/log.txt
	else
	    echo "/sbin/iptables -A FORWARD -s 10.3.1.44 -m limit --limit 3/s -j ACCEPT" >> $gxfile
	    echo "/sbin/iptables -A FORWARD -s 10.3.1.44 -j DROP" >> $gxfile
	    echo "Linux(or Other)" >> /usr/local/nat/log.txt
	fi
	/usr/local/nat/nat.sh
    fi

    preflag=$curflag
    sleep 30
done

exit 0
