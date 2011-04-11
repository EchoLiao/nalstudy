#!/bin/sh

function Usage()
{
    echo
    echo "Usage: `basename $0` -s src -d des [-k] [-b bkdir] [-u] [-a] [-r] [-e file] [-p file]" 1>&2
    echo "       -k         isUseBkDir"
    echo "       -u         isOnlyUpdate"
    echo "       -a         isSaveAllPro"
    echo "       -r         isRealSyn"
    echo
    exit 1;
}

parm=`getopt "s:d:b:kuare:p:" "$@"`
[[ $? != 0 ]] &&  Usage

# "set --" : 重新设置命令行参数
set -- $parm

#SRC="sre@scr.com::inburst"
#SRC="/home/sre/notes/"
SRC=
#DES="/tmp/rs"
DES=
BKDIRFIX="/tmp/bk/"
SFX="-`date +%Y-%m-%d`"
ExcludeFile="/home/sre/.rsyncd/exclude.files"
PassFile="/home/sre/.rsyncd/rsyncd.secrets"

isOnlyUpdate=0
isSaveAllPro=0
isUseBkDir=0
isRealSyn=0

# echo "Before loop, command line has: $*"
while :
do
    case "$1" in
        -s) shift; SRC="$1";;
        -d) shift; DES="$1";;
        -k) isUseBkDir=1;;
        -b) shift; BKDIRFIX="$1";;
        -u) isOnlyUpdate=1;;
        -a) isSaveAllPro=1;;
        -r) isRealSyn=1;;
        -e) shift; ExcludeFile="$1";;
        -p) shift; PassFile="$1";;
        --) break ;;
    esac
    shift
done
shift    # Remove the trailing --

[[ ! $SRC || ! $DES ]] && Usage
[[ $* ]] && Usage


BKDIR=$BKDIRFIX/"`date +%Y-%m-%d`/"
OPTS="-vtrR --progress "

[[ $isOnlyUpdate == 1 ]] && OPTS+="-u "
[[ $isSaveAllPro == 1 ]] && OPTS+="-l -p -t -g -o -D "
[[ $isUseBkDir == 1 ]] && OPTS+="-b --backup-dir=$BKDIR "
[[ $isUseBkDir == 0 ]] && OPTS+="-b --suffix=$SFX " && isRealSyn=0
[[ $isRealSyn == 1 ]] && OPTS+="--delete --delete-after --force --ignore-errors "
OPTS+="-C --exclude-from=$ExcludeFile "
OPTS+="--password-file=$PassFile "
echo "\$OPTS=$OPTS"
# echo "\$SRC=$SRC \$DES=$DES"

logfilefix=`echo $SRC | tr '/' '-' | sed 's/^-//' | sed 's/-$//'`
echo $logfilefix

[[ -d "$BKDIR" ]] || mkdir -p "$BKDIR"
/usr/local/bin/rsync $OPTS $SRC $DES | tee "$BKDIR"/$logfilefix.log



exit 0


rsync -vrR --progress \
          -u \
          -l -p -t -g -o -D \
          -z \
          -b --backup-dir=$BKDIR --suffix=$SFX \
          --delete --delete-after --force --ignore-errors \
          -C --exclude-from=$ExcludeFile \
          --password-file=$PassFile \
          $SRC $DES

# r    l      p        t        g    o    D
# 递归 软链接 文件权限 文件时间 属组 属主 设备文件信息

#--include-from=FILE    不排除FILE指定模式匹配的文件
#--log-format=FORMAT    指定日志文件格式
