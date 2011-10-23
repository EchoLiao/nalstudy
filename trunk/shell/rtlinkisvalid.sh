#!/bin/sh

rt=/home/scr/.rt
rtnt=/home/scr/.rt-notes
fdir="address-book gs life linux system-install-notes win"
fd=
isfindall=0
tf=/tmp/find.fileex.tmp.132422

function Usage()
{
    echo "Usage:"
    echo "  `basename $0` [-a] [-h] [dir]"
    echo "      -a      Find all files"
    echo "      -h      Disply this message"
    echo "      dir     The directory want to look up"
    echo
    echo "Description:"
    echo "  查找某一目录下是否存在坏的软链接."
    echo "  (若不带任何参数, 则查找 $rt/{$fdir}"
    echo "   目录及子目录下的所有 *.txt, README, INSTALL 文件)"
    exit 69
}

parm=`getopt "ha" "$@"`
[[ $? != 0 ]] &&  Usage

# "set --" : 重新设置命令行参数
set -- $parm

while :
do
    case "$1" in
        -a) isfindall=1;;
        -h) Usage;;
        --) break ;;
    esac
    shift
done
shift    # Remove the trailing --

if [[ "$#" == 0 || "$#" == 1 ]]; then fd="$*"; else Usage; fi

# 若没有提供要查找的目录, 则默认使用 /home/scr/.rt 作为查找的基础目录.
fd=${fd:-$rt}


cd "$fd"
if [[ $? == 0 ]]; then
    if [[ "$fd" == "$rt" || "$fd" == "$rtnt" ]]; then
        fdir="address-book gs life linux system-install-notes win"
    else
        fdir="."
    fi
    echo "THE BASE DIRECTORY IS: $fd/{$fdir}"
    if [[ $isfindall == 1 ]]; then
        find $fdir -type l > $tf
    else
        find $fdir -type l \
                -type f -iname '*.txt' -o -type f -iname 'README' -o -type f -iname 'INSTALL' \
                -o -type f -iname 'README.*' -o -type f -iname 'INSTALL.*' \
                | grep -v '\.git' | grep -v '\.svn' | grep -v 'minix.*svn'\
                | grep -v '/rfc/' | grep -v 'softEngineering' > $tf
    fi
else
    echo "Can't cd to $fd"
    exit 1
fi

cat $tf |
while read line
do
    if [ -z "$line"  ]; then continue; fi
    if [[ "$line" == "." ]]; then continue; fi
    bname=${line##*/}   # bname=`basename "$line"`
    bpath=${line%/*}    # bpath=${line/%\/$bname/}
    #echo $bpath KKKKKKKKKKKKKKKKKK $bname

    # 测试该软链接所指向的文件是否存在
    if [ ! -e "$fd/$bpath/$bname" ]; then
        echo "CAN NOT FIND THE LINKPOINT OF: $fd/$bpath/$bname" 1>&2
    fi
    #### 下面的代码也能实现这一功能.
    #xxd -l 1 "$fd/$bpath/$bname" > /dev/null 2>&1   # 测试该软链接所指向的文件是否存在
    #[[ $? != 0 ]] && {
    #    echo "CAN NOT FIND THE LINKPOINT OF: $fd/$bpath/$bname" 1>&2
    #}
done

exit 0
