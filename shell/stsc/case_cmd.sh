#!/bin/bash
#例子 10-26. 使用命令替换来产生case变量
# case_cmd.sh: 使用命令替换来产生"case"变量

case "$1" in "-h" | "--help") 
echo "Usage: ${0##*/}";
echo "例子 10-26. 使用命令替换来产生case变量";
exit $E_PARAM;;  # 没有命令行参数,
esac


case $( arch ) in   # arch" 返回机器的类型.
                    # 等价于 'uname -m' ...
i386 ) echo "80386-based machine";;
i486 ) echo "80486-based machine";;
i586 ) echo "Pentium-based machine";;
i686 ) echo "Pentium2+-based machine";;
*    ) echo "Other type of machine";;
esac

exit 0
