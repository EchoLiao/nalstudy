#/bin/sh


function Usage()
{
    echo 1>&2
    echo "Usage: `basename $0` txtfile" 1>&2
    echo 1>&2
    exit 1;
}



nv_list="/home/scr/.rt/vercol/git/lang/blog/nb-viki.list"
cpwd=`pwd -P`

tmp_list="/tmp/tmp_nbviki_add_to_list.tmp.23423.2234.tmp"


# 对参数进行验证
[[ $# != 1 ]] && {
    Usage
}
[[ ! -f "$1" ]] && {
    echo "\"$1\" is NOT a regular file!" 1>&2
    exit 2;
}
[[  "$1" == $nv_list || "$1" == `basename $nv_list` ]] && {
    echo "\"$nv_list\" Can't add to it by itself!!"
    exit 3;
}


# 若 "$1" 的第一个字符是 "/", 则 ${1%%/*} 返回空. 
dirtest=${1%%/*}

if [[ $dirtest == "" ]]; then
    nfilename=$1
else
    nfilename=$cpwd/$1
fi


cdate=`date +%Y-%m-%dT%H_%M_%S`

cat $nv_list                      > $tmp_list
echo -e "$nfilename\t$cdate.txt" >> $tmp_list


# sort默认以空白(空格和制表符)分隔字段, 并从0开始对字段开始计数.
# +0 -1   表示从对第0个字段排序, 结束于第1个字段. 即: 对只对第0个字段排序.
# -u      表示只输出"参与排序的字段中唯一的"的行.
# 第1个sort是对所有的字段(即, 整行)进行排序, 以保证创建时间较早的排在前面.
cat $tmp_list | sort | sort +0 -1 -u > $nv_list 


rm -f $tmp_list


exit 0
