#!/bin/bash
#Example 12-7. 通过名字Kill进程
# kill_byname.sh: 通过名字kill进程.
# 与脚本kill-process.sh相比较.

#  例如,
#+ 试一下 "./kill-byname.sh xterm" --
#+ 并且查看你系统上的所有xterm都将消失.

#  警告:
#  -----
#  这是一个非常危险的脚本.
#  运行它的时候一定要小心. (尤其是以root身份运行时)
#+ 因为运行这个脚本可能会引起数据丢失或产生其他一些不好的效果.

E_BADARGS=66

case "$1" in "" | "-h" | "--help") 
echo "Usage: `basename $0` Process(es)_to_kill"
echo "xargs -i; kill; grep; awk"
exit $E_BADARGS
esac


PROCESS_NAME="$1"
#ps ax | grep "$PROCESS_NAME" | awk '{print $1}' | xargs -i kill {}
ps ax | grep "$PROCESS_NAME" | awk '{print $1}' | xargs -i kill {} 2&>/dev/null
#                                                       ^^      ^^

# -----------------------------------------------------------
# 注意:
# -i 参数是xargs命令的"替换字符串"选项.
# 大括号对的地方就是替换点.
# 2&>/dev/null 将会丢弃不需要的错误消息.
# -----------------------------------------------------------

exit $?
