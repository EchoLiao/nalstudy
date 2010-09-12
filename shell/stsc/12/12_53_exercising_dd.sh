#!/bin/bash
#Example 12-53. 练习 dd
# exercising_dd.sh

case "$1" in "" | "-h" | "--help") 
echo "Usage: ${0##*/} input_file output_file start_point end_point";
echo "Example 12-53. 练习 dd";
echo "把input_file中的第start_point到end_point的字符提取出来, 并保存于output_file中!"
exit $E_PARAM;;  # 没有命令行参数,
esac

# 由Stephane Chazelas编写.
# 本文作者做了少量修改.

input_file=$0   # 脚本本身.
output_file=log.txt
n=1
p=1

if [ ! -z "$1" ]; then
    input_file="$1"
fi
if [ ! -z "$2" ]; then
    output_file="$2"
fi
if [ ! -z "$3" ]; then
    n="$3"
fi
if [ ! -z "$4" ]; then
    p="$4"
fi

##
# bs=1:	    每次读入或写入一字节数据
# skip:	    在读取数据并处理之前, 跳过n-1字节
# count:    读取count个字节
dd if=$input_file of=$output_file bs=1 skip=$((n-1)) count=$((p-n+1)) 2> /dev/null
# 从脚本中把位置n到p的字符提取出来.

# -------------------------------------------------------

##
# conv=unblock:	每输出cbs个字符就换行一次
echo -n "hello world" | dd cbs=2 conv=unblock 2> /dev/null
exit 0
