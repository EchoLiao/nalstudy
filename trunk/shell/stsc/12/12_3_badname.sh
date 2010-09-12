#!/bin/bash
#Example 12-3. 删除当前目录下文件名中包含一些特殊字符(包括空白)的文件..
# badname.sh
# 删除当前目录下文件名中包含一些特殊字符的文件.

case "$1" in "-h" | "--help") 
echo "Usage: ${0##*/}";
echo "Example 12-3. 删除当前目录下文件名中包含一些特殊字符(包括空白)的文件.";
echo "sed find"
exit $E_PARAM;;  # 没有命令行参数,
esac

for filename in *
do
  badname=`echo "$filename" | sed -n /[\+\{\;\"\\\=\?~\(\)\<\>\&\*\|\$]/p`
# badname=`echo "$filename" | sed -n '/[+{;"\=?~()<>&*|$]/p'`  这句也行.
# 删除文件名包含这些字符的文件:     + { ; " \ = ? ~ ( ) < > & * | $
#
	if [ $badname ]; then
		echo "$badname"
	fi
  #rm $badname 2>/dev/null # OOOOO 
#             ^^^^^^^^^^^ 错误消息将被抛弃.
done

echo "============================================================="
# 现在, 处理文件名中以任何方式包含空白的文件.
#find . -name "* *" -exec rm -f {} \; # OOOOO
find . -name "* *" -exec echo {} \;
# "find"命令匹配到的目录名将替换到{}的位置.
# '\' 是为了保证 ';'被正确的转义, 并且放到命令的结尾.

exit 0

#---------------------------------------------------------------------
# 这行下边的命令将不会运行, 因为 "exit" 命令.

# 这句是上边脚本的一个可选方法:
find . -name '*[+{;"\\=?~()<>&*|$ ]*' -exec rm -f '{}' \;
# (Thanks, S.C.)
