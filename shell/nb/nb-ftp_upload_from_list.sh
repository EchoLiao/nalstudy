#/bin/sh

# 批量自动上传文件脚本



[[ $# != 1 ]] && {
    echo "Usage: `basename $0` listfile"
    exit 1
}



slist="$1"
ftpsh1="$HOME/.ftp_updown_tmp_3232222_tmp_1.sh"
ftpsh2="$HOME/.ftp_updown_tmp_3232222_tmp_2.sh"
logdir="./log"
outlog="$logdir/ftp_upload_out."`date "+%Y-%m-%dT%H_%M_%S"`".log"
errlog="$logdir/ftp_upload_err."`date "+%Y-%m-%dT%H_%M_%S"`".log"
npwd=`pwd -P`
mkdir -p $logdir

######==######
# 由于 ftp 服务器不支持用 mkdir 创建多层目录, 所以我们只能一层一层地创建; 又由
# 于我们不知道服务器上是否已经有我们想要创建的目录, 所以我们只能假设服务器上没
# 有任何目录, 每次要创建目录, 我们都会一层一层地创建下去!
do_create_mklist()
{
    # aa/bb/cc/dd/file
    tpathres=$1         # 用于保存不断减去第一个path剩下的部分
    tlastname=${1##*/}  # 不包括路径的文件名
    prvpath=.           # 用于保存路径部分, 其不断地加长

    cat /dev/null > $2
    for (( ; 0 == 0; ))
    do
        if [[ $tpathres == $tlastname ]]; then break; fi
        st=${tpathres%%/*}
        tpathres=${tpathres#*/}
        prvpath=$prvpath/$st
        echo "mkdir $prvpath" >> $2
    done
}



######==######
# 对文件列表中所有文件构造出 ftp 上传命令, 并执行
# 构造 ftp 操作命令
echo "ftp -n -i -v 221.1.217.92 << END"    >  $ftpsh1
echo "user nuoerlz google8"                 >> $ftpsh1
echo "binary"                              >> $ftpsh1
echo "hash"                                >> $ftpsh1

cat $slist |
while read line
do
    if [ -z "$line"  ]; then continue; fi
    sdir=${line%/*}     # 路径部分
    sfile=${line##*/}   # 不包括路径的文件名
    sdir=`echo $sdir | sed 's:^./::'`   # 去掉前两个字符"./"
    line=`echo $line | sed 's:^./::'`   # 去掉前两个字符"./"

    echo "cd /"                        >> $ftpsh1
    echo "cd /"                        >> $ftpsh1
    echo "cd /"                        >> $ftpsh1
    do_create_mklist $line $ftpsh2
    cat $ftpsh2                        >> $ftpsh1
    echo "cd /$sdir"                   >> $ftpsh1
    echo "lcd $npwd/$sdir"             >> $ftpsh1
    echo "prompt"                      >> $ftpsh1
    echo "mput $sfile"                 >> $ftpsh1
done

echo "bye"                                 >> $ftpsh1
echo "END"                                 >> $ftpsh1


# 运行构造出来的 ftp 命令
/bin/sh $ftpsh1 2>$errlog 1>$outlog


#rm -f $ftpsh1 $ftpsh2 $slist

exit 0


#ftp -n -i -v 221.1.217.92 <<END
#user nuoerlz xxxxxx
#binary
#hash
#cd /
#mkdir -p /$sdir
#cd /$sdir
#lcd $npwd/$sdir
#prompt
#mput $sfile
#bye
#END



