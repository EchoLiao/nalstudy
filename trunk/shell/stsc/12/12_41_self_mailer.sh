#!/bin/sh
#Example 12-41. 一个可以mail自己的脚本
# self_mailer.sh: mail自己的脚本
# mail:
#    发送或读取 e-mail 消息.
#    如果把这个命令行的 mail 客户端当成一个脚本中的命令来使用的话, 效果非常好.

case "$1" in "" | "-h" | "--help") 
echo "Usage: ${0##*/} [username]";
echo "Example 12-41. 一个可以mail自己的脚本";
exit $E_PARAM;;  # 没有命令行参数,
esac


adr=${1:-`whoami`}     # 如果不指定的话, 默认是当前用户.
#  键入 'self-mailer.sh wiseguy@superdupergenius.com'
#+ 发送这个脚本到这个地址.
#  如果只键入 'self-mailer.sh' (不给参数) 的话, 那么这脚本就会被发送给
#+ 调用者, 比如 bozo@localhost.localdomain.
#
#  如果想了解 ${parameter:-default} 结构的更多细节,
#+ 请参见第9章 变量重游中的
#+ 第3节 参数替换.

# ============================================================================
  cat $0 | mail -s "Script \"`basename $0`\" has mailed itself to you." "$adr"
# ============================================================================

# --------------------------------------------
#  来自 self-mailing 脚本的一份祝福.
#  一个喜欢恶搞的家伙运行了这个脚本,
#+ 这导致了他自己收到了这份mail.
#  显然的, 有些人确实没什么事好做,
#+ 就只能浪费他们自己的时间玩了.
# --------------------------------------------

echo "At `date`, script \"`basename $0`\" mailed to "$adr"."

exit 0
