#!/bin/bash
#Example 12-6. 把当前目录下的文件拷贝到另一个目录中
# copydir.sh

#  拷贝 (verbose) 当前目录($PWD)下的所有文件到
#+ 命令行中指定的另一个目录下.

E_NOARGS=65

case "$1" in "" | "-h" | "--help") 
echo "Usage: `basename $0` directory-to-copy-to"
echo "Example 12-6. 把当前目录下的文件拷贝到另一个目录中"
echo "xargs"
exit $E_NOARGS
esac

ls . | xargs -i -t cp ./{} $1
#            ^^ ^^      ^^
#  -t 是 "verbose" (输出命令行到stderr) 选项.
#  -i 是"替换字符串"选项.
#  {} 是输出文本的替换点.
#  这与在"find"命令中使用{}的情况很相像.
#
#  列出当前目录下的所有文件(ls .),
#+ 将 "ls" 的输出作为参数传递到 "xargs"(-i -t 选项) 中,
#+ 然后拷贝(cp)这些参数({})到一个新目录中($1).
#
#  最终的结果和下边的命令等价,
#+   cp * $1
#+ 除非有文件名中嵌入了"空白"字符.

exit 0
