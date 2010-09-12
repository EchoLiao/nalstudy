#!/bin/bash
#Example 12-10. 使用 date 命令
# 练习 'date' 命令

case "$1" in "-h" | "--help") 
echo "Usage: ${0##*/}";
echo "Example 12-10. 使用 date 命令";
echo "date +%j; date +%s; $$"
exit $E_PARAM;;  # 没有命令行参数,
esac

echo "The number of days since the year's beginning is `date +%j`."
# 需要在调用格式的前边加上一个 '+' 号.
# %j 给出今天是本年度的第几天.

echo "The number of seconds elapsed since 01/01/1970 is `date +%s`."
#  %s 将产生从 "UNIX 元年" 到现在为止的秒数,yields number of seconds since "UNIX epoch" began,
#+ 但是这东西有用么?

sleep 1
prefix=temp
suffix=$(date +%s)  # 'date'命令的 "+%s" 选项是 GNU-特性.
filename=$prefix.$suffix
echo $filename
#  这是一种非常好的产生 "唯一" 的临时文件的办法,
#+ 甚至比使用 $$ 都强.
echo $$ # 本script进程pid

# 如果想了解 'date' 命令的更多选项, 请查阅这个命令的 man 页.

exit 0
