#!/bin/bash
#Example 12-21. rot13: rot13, 弱智加密.
# rot13.sh: 典型的 rot13 算法,
#           使用这种方法加密可能可以愚弄一下3岁小孩.

case "$1" in "-h" | "--help") 
echo "Usage: ${0##*/}";
echo "Example 12-21. rot13: rot13, 弱智加密.";
echo "cat \"\$@\""
exit $E_PARAM;;  # 没有命令行参数,
esac

# 用法: ./rot13.sh filename
# 或    ./rot13.sh <filename
# 或    ./rot13.sh and supply keyboard input (stdin)

cat "$@" | tr 'a-zA-Z' 'n-za-mN-ZA-M'   # "a" 变为 "n", "b" 变为 "o", 等等.
#  'cat "$@"' 结构
#+ 允许从stdin或者从文件中获得输入.

exit 0
