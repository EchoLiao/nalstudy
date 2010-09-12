#!/bin/bash
#Example 12-12. 那个文件是脚本?
# script_detector.sh: 在一个目录中检查所有的脚本文件.

case "$1" in "-h" | "--help") 
echo "Usage: ${0##*/}";
echo "Example 12-12. 那个文件是脚本?";
echo "head -c"
exit $E_PARAM;;  # 没有命令行参数,
esac

TESTCHARS=2    # 测试前两个字节.
SHABANG='#!'   # 脚本都是以 "sha-bang." 开头的.

for file in *  # 遍历当前目录下的所有文件.
do
  if [[ `head -c$TESTCHARS "$file"` = "$SHABANG" ]]
  then
    echo "File \"$file\" is a script."
  else
    echo "File \"$file\" is *not* a script."
  fi
done
  
exit 0

#  练习:
#  -----
#  1) 将这个脚本修改为可以指定目录
#+    来扫描目录下的脚本.
#+    (而不是只搜索当前目录).
#
#  2) 就目前看来, 这个脚本将不能正确识别出
#+    Perl, awk, 和其他一些脚本语言的脚本文件.
#     修正这个问题.
