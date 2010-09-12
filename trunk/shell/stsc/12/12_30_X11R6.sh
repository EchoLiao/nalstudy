#!/bin/bash
#Example 12-30. Exploring /usr/X11R6/bin

case "$1" in "-h" | "--help") 
echo "Usage: ${0##*/}";
echo "Example 12-30. Exploring /usr/X11R6/bin";
echo "whatis"
exit $E_PARAM;;  # 没有命令行参数,
esac

# 在 /usr/X11R6/bin 中的所有神秘的2进制文件都是什么东西?

DIRECTORY="/bin"
# 也试试 "/bin", "/usr/bin", "/usr/local/bin", 等等.

for file in $DIRECTORY/*
do
  whatis `basename $file`   # 将会 echo 出这个2进制文件的信息.
done

exit 0

# 你可能希望将这个脚本的输出重定向, 像这样:
# ./what.sh >>whatis.db
# 或者一页一页的在 stdout 上查看,
# ./what.sh | less
