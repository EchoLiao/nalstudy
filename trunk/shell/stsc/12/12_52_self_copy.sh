#!/bin/bash
#Example 12-52. 一个拷贝自身的脚本
# self_copy.sh
# 这个脚本将会拷贝自身.

case "$1" in "" | "-h" | "--help")
echo "Usage: ${0##*/}";
echo "Example 12-52. 一个拷贝自身的脚本";
echo "dd"
exit $E_PARAM;;  # 没有命令行参数,
esac

# 这也是一个不太出名的工具, 但却是一个令人恐惧的 "数据复制" 命令. 最开始, 这个
# 命令是被用来在UNIX 微机和IBM大型机之间通过磁带来交换数据, 这个命令现在仍然有
# 它的用途. dd 命令只不过是简单的拷贝一个文件 (或者 stdin/stdout), 但是它会做
# 一些转换. 下边是一些可能的转换, 比如 ASCII/EBCDIC, [4]  大写/小写, 在输入和
# 输出之间的字节对的交换, 还有对输入文件做一些截头去尾的工作. dd --help  列出
# 了所有转换, 还有这个强力工具的一些其他选项.

## 将一个文件转换为大写:
# dd if=$filename conv=ucase > $filename.uppercase
#                    lcase   # 转换为小写



file_subscript=copy

dd if=$0 conv=ucase of=$0.$file_subscript 2>/dev/null
# 阻止dd产生的消息:            ^^^^^^^^^^^

exit $?
