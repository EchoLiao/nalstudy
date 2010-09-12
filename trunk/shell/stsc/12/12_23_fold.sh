#!/bin/bash
#Example 12-23. 格式化文件列表.

case "$1" in "-h" | "--help") 
echo "Usage: ${0##*/}";
echo "Example 12-23. 格式化文件列表.";
echo "fmt; fold"
exit $E_PARAM;;  # 没有命令行参数,
esac

WIDTH=80                    # 设为80列宽.

b=`ls /usr/local/bin`       # 取得文件列表...

echo $b | fmt -w $WIDTH

# 也可以使用如下方法,作用相同
#echo $b | fold - -s -w $WIDTH
 
exit 0
