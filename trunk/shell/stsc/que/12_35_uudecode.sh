#!/bin/bash
#Example 12-35. Uudecod 编码后的文件
# 在当前目录下 uudecode 所有用 uuencode 编码的文件.
###
# uuencode
#    这个工具用来把二进制文件编码成 ASCII 字符串,这个工具适用于编码e-mail消息体,或者新闻组消息.
# uudecode
#    这个工具用来把 uuencode 后的 ASCII 字符串恢复为二进制文件.

case "$1" in "" | "-h" | "--help") 
    echo "Usage: ${0##*/}";
    echo "Example 12-35. Uudecod 编码后的文件";
    echo "uuencode; uudecode"
    exit $E_PARAM;;  # 没有命令行参数,
esac

lines=35        # 允许读头部的 35 行(范围很宽).

for File in *   # Test 所有 $PWD 下的文件.
do
    search1=`head -$lines $File | grep begin | wc -w`
    search2=`tail -$lines $File | grep end | wc -w`
    #  Uuencode 过的文件在文件开始的地方有个 "begin",
    #+ 在文件结尾的地方有个 "end".
    if [ "$search1" -gt 0 ] # 大于 
    then
	if [ "$search2" -gt 0 ]
	then
	    echo "uudecoding - $File -"
	    uudecode $File # uudecode 没有安装 
	fi  
    fi
done  

#  小心不要让这个脚本运行自己,
#+ 因为它也会把自身也认为是一个 uuencoded 文件,
#+ 这都是因为这个脚本自身也包含 "begin" 和 "end".

#  练习:
#  -----
#  修改这个脚本, 让它可以检查一个新闻组的每个文件,
#+ 并且如果下一个没找的话就跳过.

exit 0
