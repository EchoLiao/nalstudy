#!/bin/bash
#Example 12-25. nl: 一个自己计算行号的脚本.
# line_number.sh

case "$1" in "-h" | "--help") 
echo "Usage: ${0##*/}";
echo "Example 12-25. nl: 一个自己计算行号的脚本.";
echo "nl; cat -n"
exit $E_PARAM;;  # 没有命令行参数,
esac

# 这个脚本将会 echo 自身两次, 并显示行号.

# 'nl' 命令显示的时候你将会看到, 本行是第4行, 因为它不计空行.
# 'cat -n' 命令显示的时候你将会看到, 本行是第6行.

nl `basename $0`

echo; echo  # 下边, 让我们试试 'cat -n'

cat -n `basename $0`
# 区别就是 'cat -n' 对空行也进行计数.
# 注意 'nl -ba' 也会这么做.

exit 0
# -----------------------------------------------------------------
