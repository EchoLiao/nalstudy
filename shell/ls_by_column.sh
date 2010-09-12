#!/bin/bash
#Example 12-24. 使用 column 来格式化目录列表
# 这是"column" man页中的一个例子, 作者对这个例子做了很小的修改.

case "$1" in "-h" | "--help") 
echo "Usage: ${0##*/}";
echo "Example 12-24. 使用 column 来格式化目录列表";
echo "column -t; printf"
exit $E_PARAM;;  # 没有命令行参数,
esac

#(printf "PERMISSIONS LINKS OWNER GROUP SIZE MONTH-DAY HH:MM PROG-NAME\n" \
#; ls -l --color | sed 1d) | column -t

#  管道中的 "sed 1d" 删除输出的第一行,
#+ 第一行将是 "total        N",
#+ 其中 "N" 是 "ls -l" 找到的文件总大小.
# "column" 中的 -t 选项用来转化为易于打印的表形式.

(printf "PERMISSIONS LINKS OWNER GROUP SIZE MONTH-DAY HH:MM PROG-NAME\n" \
; ls -lh --color ) | column -t


exit 0
