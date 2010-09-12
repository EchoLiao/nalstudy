#!/bin/bash
#Example 12-28. 解包一个 rpm 归档文件
# de_rpm.sh: 解包一个 'rpm' 归档文件

case "$1" in "-h" | "--help") 
echo "Usage: `basename $0` target-file";
echo "Example 12-28. 解包一个 rpm 归档文件";
echo "cpio; rpm2cpio"
exit $E_PARAM;;  # 没有命令行参数,
esac

#: ${1?"Usage: `basename $0` target-file"}
# 必须指定 'rpm' 归档文件名作为参数.


TEMPFILE=$$.cpio                         # Tempfile 必须是一个"唯一"的名字.
                                         # $$ 是这个脚本的进程 ID.

rpm2cpio < $1 > $TEMPFILE                # 将rpm归档文件转换为 cpio 归档文件.
cpio --make-directories -F $TEMPFILE -i  # 解包 cpio 归档文件.
rm -f $TEMPFILE                          # 删除 cpio 归档文件.

exit 0

#  练习:
#  添加一些代码来检查    1) "target-file" 是否存在
#+                       2) 这个文件是否是一个 rpm 归档文件.
#  暗示:                    分析 'file' 命令的输出.
