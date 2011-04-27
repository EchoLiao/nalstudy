#!/bin/sh

function Usage()
{
    echo 1>&2
    echo "Usage: `basename $0` -d database -p dbpath -i import -m comment [-h]" 1>&2
    echo "       -h         help"         1>&2
    echo "       -d db      set db"       1>&2
    echo "       -p dbpath  set db"       1>&2
    echo "       -i import  import files" 1>&2
    echo "       -m comment" 1>&2
    echo 1>&2
    echo "`basename $0` -d routerconfig -p zzb/tools -i ./rou "
    echo 1>&2
    exit 1;
}

parm=`getopt "hd:p:i:m:" "$@"`
[[ $? != 0 ]] &&  Usage

# "set --" : 重新设置命令行参数
set -- $parm

dB=
dBPath=
iMPT=
comment=
while :
do
    case "$1" in
        -h) Usage;;
        -d) shift; dB="$1";;
        -p) shift; dBPath="$1";;
        -i) shift; iMPT="$1";;
        -m) shift; comment="$1";;
        --) shift; break ;;
    esac
    shift
done

[[ ! $dB || ! $dBPath || ! $iMPT ]] && Usage
[[ $* ]] && Usage

#===================================================================

mkdir -p /var/svn/$dBPath
svnadmin create /var/svn/$dBPath/$dB
svn import $iMPT file:///var/svn/$dBPath/$dB -m "initial import"

rm -f /var/svn/$dBPath/$dB/conf/{authz,passwd,svnserve.conf}
cp /var/svn/3dai/conf/svnserve.conf /var/svn/$dBPath/$dB/conf/

sed "s/^realm = .*$/realm = $comment/" /var/svn/$dBPath/$dB/conf/svnserve.conf > /tmp/svn-my-tmp
mv -f /tmp/svn-my-tmp /var/svn/$dBPath/$dB/conf/svnserve.conf


exit 0


mkdir -p /var/svn/zzb/tools
svnadmin create /var/svn/zzb/tools/routerconfig
svn import rou/ file:///var/svn/zzb/tools/routerconfig/ -m initial import
