#!/bin/bash
#Example 12-14. 使用 tail 命令来监控系统log

case "$1" in "-h" | "--help") 
echo "Usage: ${0##*/}";
echo "Example 12-14. 使用 tail 命令来监控系统log";
echo "cat /dev/null > filename; tail"
exit $E_PARAM;;  # 没有命令行参数,
esac

filename=sys.log

cat /dev/null > $filename; echo "Creating / cleaning out file."
#  如果文件不存在的话就创建文件,
#+ 然后将这个文件清空.
#  : > filename   和   > filename 也可以完成这个工作.

tail /var/log/messages > $filename  
# /var/log/messages 必须具有全局可读权限才行.

echo "$filename contains tail end of system log."

exit 0
