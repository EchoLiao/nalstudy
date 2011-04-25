#!/bin/sh

case "$1" in "-h" | "--help")
echo "Usage: ${0##*/}";
echo "把十六进制文件的数据转换为二进制并输出到标准输出";
echo
echo "输入文件格式:"
echo "  03 80 01 C0"
echo "  06 C0 03 60"
echo "  04 60 06 20"
echo "  ..."
echo
echo "bc; printf"
echo
exit $E_PARAM;;  # 没有命令行参数,
esac



while read v0 v1 v2 v3
do
    #echo "$v0 $v1 $v2 $v3"
    t0=`echo "ibase=16; obase=2; $v0" | bc`
    t1=`echo "ibase=16; obase=2; $v1" | bc`
    t2=`echo "ibase=16; obase=2; $v2" | bc`
    t3=`echo "ibase=16; obase=2; $v3" | bc`
    # echo $t0 $t1 $t2 $t3
    printf "%08d%08d%08d%08d" $t0 $t1 $t2 $t3
    echo
done <$1

exit 0

#[~]$ cat $1
#00 00 00 00
#00 00 00 00
#03 80 01 C0
#06 C0 03 60
#04 60 06 20
#04 30 0C 20
#04 18 18 20
#04 0C 30 20
#04 06 60 20
#44 03 C0 22
#44 01 80 22
#44 01 80 22
#44 01 80 22
#44 01 80 22
#44 01 80 22
#44 01 80 22
#66 01 80 66
#33 01 80 CC
#19 81 81 98
#0C C1 83 30
#07 E1 87 E0
#03 3F FC C0
#03 31 8C C0
#03 33 CC C0
#06 64 26 60
#0C CC 33 30
#18 CC 33 18
#10 C4 23 08
#10 63 C6 08
#10 30 0C 08
#10 18 18 08
#10 00 00 08
