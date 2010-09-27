#!/bin/bash

# 还原grep的选项
export GREP_OPTIONS=
export GREP_COLOR=


iffiles="/etc/sysconfig/network-scripts/ifcfg-eth*"
tmpfile1="/tmp/tmpAAAAAAAAAAAA1"
tmpfile2="/tmp/tmpAAAAAAAAAAAA2"
ifdevname=""
ifdevname_real=""

do_pre()
{
    #ifdevname=`cat $iffiles | grep 'DEVICE=' | awk -F\' {'print $2'} | sort | head -n 1`
    ifdevname=`ls /etc/sysconfig/network-scripts/ifcfg-eth* | awk {'print $1'} | head -n 1 | awk -F- {'print $3'}`

    ifdevname_real=`ip a | grep eth[0-9]:\ \<.*\>.*mtu | awk -F: {'print $2'} | sed "s/\ //g"`
}

do_chiffile()
{
    iffile_prefix="/etc/sysconfig/network-scripts/ifcfg-"
    iffile=""
    iffile_alias=""

    iffile=$iffile_prefix$ifdevname
    iffile_alias=$iffile_prefix$ifdevname:0

    # 要使用变量必须要使用双引号, 不能用单引号!
    sed "s/$ifdevname/$ifdevname_real/g" $iffile > $tmpfile1
    sed "s/$ifdevname/$ifdevname_real/g" $iffile_alias > $tmpfile2
    rm -f $iffile
    rm -f $iffile_alias
    mv $tmpfile1 $iffile_prefix$ifdevname_real
    mv $tmpfile2 $iffile_prefix$ifdevname_real:0
}

do_chmthfile()
{
    mthfile="/etc/mentohust.conf"
    sed "s/$ifdevname/$ifdevname_real/g" $mthfile > $tmpfile1
    rm -f $mthfile
    mv $tmpfile1 $mthfile
}

do_chrc()
{
    rcfile="/home/scr/bin/rc.d/rc.local.sh"
    sed "s/$ifdevname/$ifdevname_real/g" $rcfile > $tmpfile1
    rm -f $rcfile
    mv $tmpfile1 $rcfile
}

do_chnat()
{
    natfile="/usr/local/nat/nat.sh"
    sed "s/$ifdevname/$ifdevname_real/g" $natfile > $tmpfile1
    rm -f $natfile
    mv $tmpfile1 $natfile
}


# main {
do_pre
if [ "$ifdevname" ==  "$ifdevname_real" ]; then
    echo '$ifdevname == $ifdevname_real'
    exit 0
fi
do_chiffile
#ifdevname="eth2"
#ifdevname_real="eth0"
do_chmthfile
do_chrc
do_chnat
echo $ifdevname
echo $ifdevname_real
# }


exit 0
