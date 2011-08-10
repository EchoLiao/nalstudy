#!/bin/sh

# ~/bin/unison/test.prf 配置文件中等号(=)左边最少要有一个空格,
# 该脚本才能正确运行!

function Usage()
{
    echo 1>&2
    echo -n "Usage: `basename $0` -a dir1 -b dir2 -k backdir -p prefix" 1>&2
    echo    " -s suffix -l logdir" 1>&2
    echo 1>&2
    exit 1;
}

function addAbsolutionPath()
{
    [[ -z $1 ]] && {
        echo "MUST order one param to addAbsolutionPath()!"
        exit 21
    }

    firstCh=${1:0:1}
    [[ $firstCh != "/" ]] && Pwd=`pwd`/
    ABroot=$Pwd$1
}


parm=`getopt "a:b:k:p:s:l:" "$@"`
[[ $? != 0 ]] &&  Usage
#Usage && exit 1

# "set --" : 重新设置命令行参数
set -- $parm

root1=/home/ss1
root2=/home/ss2
batch=true
auto=true
backupdir=$HOME/var/backups/unison
backupprefix=
backupsuffix=\.UBak-\$VERSION
logdir=$HOME/var/logs/unison
logfile=
prf=


while :
do
    case "$1" in
        -a) shift;
            addAbsolutionPath $1;
            root1=$ABroot;;
        -b) shift;
            addAbsolutionPath $1;
            root2=$ABroot;;
        -k) shift; backupdir="$1";;
        -p) shift; backupprefix="$1";;
        -s) shift; backupsuffix="$1"-\$VERSION;;
        -l) shift; logdir="$1";;
        --) break ;;
    esac
    shift
done
shift    # Remove the trailing --


r1=`basename $root1`
r2=`basename $root2`
backupdir=$backupdir/$r1--$r2/`date +%Y-%m-%d`
logfile=$logdir/$r1--$r2/`date +%Y-%m-%d`.log
logfile_out=$logdir/$r1--$r2/`date +%Y-%m-%d`.out.log
logfile_err=$logdir/$r1--$r2/`date +%Y-%m-%d`.err.log
prf=$r1--$r2.prf

mkdir -p $backupdir
mkdir -p $logdir/$r1--$r2
touch -f $root1/unison-mountpoint-flag-file
touch -f $root2/unison-mountpoint-flag-file

#echo $r1 $r2
#echo $root1,$root2,$batch,$auto,$backupdir,$backupprefix,$backupsuffix,$logfile,$prf


sed "

## Set two root of the synchronization
/^root *=/,/root *=/s:\(root *=\).*$:\1 "$root2":
/^## Roots/,/root *=/s:\(root *=\).*$:\1 "$root1":

## batch
/^batch *=/s:\(batch *=\).*$:\1 "$batch":

## auto
/^auto *=/s:\(auto *=\).*$:\1 "$auto":

## backupdir
/^backupdir *=/s:\(backupdir *=\).*$:\1 "$backupdir":

## backupprefix
/^backupprefix *=/s:\(backupprefix *=\).*$:\1 "$backupprefix":

## backupsuffix
/^backupsuffix *=/s:\(backupsuffix *=\).*$:\1 "$backupsuffix":

## logfile
/^logfile *=/s:\(logfile *=\).*$:\1 "$logfile":

" ~/bin/unison/test.prf > $prf


chmod 600 ./$prf
chmod 600 ~/bin/unison/common

mv -f ./$prf    ~/.unison/
cp -f ~/bin/unison/common  ~/.unison/
#unison $prf -ui text
unison $prf -ui text 1>$logfile_out 2>$logfile_err
cat $logfile_err

exit 0

