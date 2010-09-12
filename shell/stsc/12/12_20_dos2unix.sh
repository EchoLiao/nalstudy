#!/bin/bash
#Example 12-20. Du: DOS 到 UNIX 文本文件的转换.
# dos2unix.sh: DOS 到 UNIX 文本文件的转换.

E_WRONGARGS=65

case "$1" in "-h" | "--help") 
echo "Usage: `basename $0` filename_to_convert"
echo "Example 12-20. Du: DOS 到 UNIX 文本文件的转换.";
echo "tr -d"
exit $E_WRONGARGS
esac

NEWFILENAME=$1.unix

CR='\015'  # 回车Carriage return.
           # 015 是 8 进制的 ASCII 码的回车.
           # DOS 中文本文件的行结束符是 CR-LF.
           # UNIX 中文本文件的行结束符只是 LF.

tr -d $CR < $1 > $NEWFILENAME
# 删除回车并且写到新文件中.

echo "Original DOS text file is \"$1\"."
echo "Converted UNIX text file is \"$NEWFILENAME\"."

exit 0

# 练习:
# -----
# 修改上边的脚本完成从UNIX 到 DOS 的转换.
