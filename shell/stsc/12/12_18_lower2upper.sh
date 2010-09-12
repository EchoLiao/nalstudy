#!/bin/bash
#Example 12-18. 转换大写: 把一个文件的内容全部转换为大写.
# 把一个文件的内容全部转换为大写.

E_BADARGS=65

case "$1" in "-h" | "--help") 
echo "Usage: ${0##*/} filename";
echo "Example 12-18. 转换大写: 把一个文件的内容全部转换为大写.";
echo "tr a-z A-Z < \"$1\""
exit $E_BADARGS
esac

tr a-z A-Z <"$1"

# 与上边的作用相同, 但是使用了 POSIX 字符集标记方法:
#        tr '[:lower:]' '[:upper:]' <"$1"
# Thanks, S.C.

exit 0

#  练习:
#  重写这个脚本, 通过选项可以控制脚本或者
#+ 转换为大写或者转换为小写.
