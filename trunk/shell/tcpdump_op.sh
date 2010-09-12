#!/bin/bash

case "$1" in "" | "-h" | "--help")
    echo "Usage   : ${0##*/} filename";
    echo "Example : ${0##*/} tmp";
    echo
    echo "Description:"
    echo "  用于处理 tcpdump 的输出, 在每一行前加上时间间隔."
    echo
    exit 67;;  # 没有命令行参数,
esac


g_ret=0

# do_preop arg0
do_preop()
{
count=0
readline0=""
readline1=""
if [ -e "$1" ]; then
    cat $1 |
    while read line
    do
	if [ -z "$line"  ]; then  # 空行
	    continue
	fi
        if [ $count -eq 0 ]; then
            readline0=$line
            ((count++))
            printf "%7d %s\n"   0 "$readline0"
            continue
        fi
	readline1=$line

	head0=`echo $readline0 | awk '{ print $1 }'`
	head1=`echo $readline1 | awk '{ print $1 }'`

        do_cal $head0 $head1 # calculation
        printf "%7d %s\n"   $g_ret "$readline1"

        readline0=$readline1
    done
else
    echo "找不到文件: $1"
    exit 1
fi
}


# do_cal arg0 arg1
# do_cal 15:08:14.607197 15:08:14.607527
do_cal()
{
    hms0=`echo $1 | awk -F. '{ print $1 }'` # 15:08:14
    hms1=`echo $2 | awk -F. '{ print $1 }'` # 15:08:14
    mis0=`echo $1 | awk -F. '{ print $2 }'` # 607197
    mis1=`echo $2 | awk -F. '{ print $2 }'` # 607527
    let "minu_hms=`date +%s -d $hms1` - `date +%s -d $hms0`"
    let "minu_mis=$mis1 - $mis0"
    let "g_ret=$minu_hms * 1000000 + $minu_mis"
}

# main {
    do_preop $1

    exit 0
# }



# [~]$ cat tmp
# 15:08:14.607197 IP gateway.49720 > sun.scr.com.daytime: S 1539565:1539565(0) win 5840 <mss 1460,sackOK,timestamp 28322689 0,nop,wscale 6>
# 15:08:14.607527 IP sun.scr.com.daytime > gateway.49720: S 198714772:198714772(0) ack 1539566 win 5792 <mss 1460,sackOK,timestamp 185662761 28322689,nop,wscale 4>
# 15:08:14.607574 IP gateway.49720 > sun.scr.com.daytime: . ack 1 win 92 <nop,nop,timestamp 28322689 185662761>
# 15:08:14.608641 IP sun.scr.com.daytime > gateway.49720: P 1:2(1) ack 1 win 362 <nop,nop,timestamp 185662762 28322689>
# 15:08:14.608701 IP gateway.49720 > sun.scr.com.daytime: . ack 2 win 92 <nop,nop,timestamp 28322690 185662762>
# 15:08:14.608898 IP sun.scr.com.daytime > gateway.49720: P 2:3(1) ack 1 win 362 <nop,nop,timestamp 185662762 28322690>
# 15:08:14.608931 IP gateway.49720 > sun.scr.com.daytime: . ack 3 win 92 <nop,nop,timestamp 28322691 185662762>
# 15:08:14.609111 IP sun.scr.com.daytime > gateway.49720: P 3:4(1) ack 1 win 362 <nop,nop,timestamp 185662763 28322691>
# 15:08:14.609140 IP gateway.49720 > sun.scr.com.daytime: . ack 4 win 92 <nop,nop,timestamp 28322691 185662763>
# 15:08:14.609268 IP sun.scr.com.daytime > gateway.49720: P 4:5(1) ack 1 win 362 <nop,nop,timestamp 185662763 28322691>
# 15:08:14.609296 IP gateway.49720 > sun.scr.com.daytime: . ack 5 win 92 <nop,nop,timestamp 28322691 185662763>
# 15:08:14.609419 IP sun.scr.com.daytime > gateway.49720: P 5:6(1) ack 1 win 362 <nop,nop,timestamp 185662763 28322691>
# 15:08:14.609447 IP gateway.49720 > sun.scr.com.daytime: . ack 6 win 92 <nop,nop,timestamp 28322691 185662763>
