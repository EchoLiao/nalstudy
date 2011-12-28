#!/bin/sh

# 批量自动上传文件脚本

ftpsh1=~/.ftp_updown_tmp_3232222_tmp_1.sh
ftpsh2=~/.ftp_updown_tmp_3232222_tmp_2.sh
npwd=`pwd -P`

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
# 对要上传的文件构造出 ftp 上传命令, 并执行
line="$1"
sdir=${line%/*}     # 路径部分
sfile=${line##*/}   # 不包括路径的文件名
sdir=`echo $sdir | sed 's:^./::'`   # 去掉前两个字符"./"
line=`echo $line | sed 's:^./::'`   # 去掉前两个字符"./"

# 构造 ftp 创建目录和上传文件的命令
echo "cd /"                                 > $ftpsh1
do_create_mklist $line $ftpsh2
cat $ftpsh2                                >> $ftpsh1
echo "cd /$sdir"                           >> $ftpsh1
echo "lcd $npwd/$sdir"                     >> $ftpsh1
echo "prompt"                              >> $ftpsh1
echo "mput $sfile"                         >> $ftpsh1

# 运行构造出来的 ftp 命令
/bin/sh $ftpsh1


rm -f $ftpsh1 $ftpsh2

exit 0
