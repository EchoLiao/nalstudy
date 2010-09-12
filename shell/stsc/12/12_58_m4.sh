#!/bin/bash
#Example 12-58. 使用 m4
# m4.sh: 使用 m4 宏处理器

case "$1" in "-h" | "--help") 
echo "Usage: ${0##*/}";
echo "Example 12-58. 使用 m4";
exit $E_PARAM;;  # 没有命令行参数,
esac

# 字符操作
string=abcdA01
echo "len($string)" | m4                           # 7
echo "substr($string,4)" | m4                      # A01  剪除掉下标为0-4的字串
echo "regexp($string,[0-1][0-1],\&Z)" | m4         # 01Z

# 算术操作
echo "incr(22)" | m4                               # 23
echo "eval(99 / 3)" | m4                           # 33

exit 0
