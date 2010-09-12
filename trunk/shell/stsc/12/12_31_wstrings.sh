#!/bin/bash
#Example 12-31. 一个"改进过"的 strings  命令
# wstrings.sh: "word-strings" (增强的 "strings" 命令)
#
#  这个脚本将会过滤 "strings" 命令的输出.
#+ 通过排除标准单词列表的形式检查来过滤输出.
#  这将有效的过滤掉无意义的字符,
#+ 并且指挥输出可以识别的字符.

case "$1" in "" | "-h" | "--help") 
echo "Usage: `basename $0` filename"
echo "Example 12-31. 一个"改进过"的 strings  命令";
echo "tr; grep -Fw; strlen=\${#word}:字符串长度"
exit $E_BADARGS
esac

# ===========================================================
#                 脚本参数的标准检查
ARGS=1
E_BADARGS=65
E_NOFILE=66


if [ ! -f "$1" ]                      # 检查文件是否存在.
then
    echo "File \"$1\" does not exist."
    exit $E_NOFILE
fi
# ===========================================================


MINSTRLEN=3                           #  最小的字符串长度.
WORDFILE=/usr/share/dict/linux.words  #  字典文件.
                                      #  也可以指定一个不同的
                                      #+ 单词列表文件,
                                      #+ 但这种文件必须是以每个单词一行的方式进行保存.


wlist=`strings "$1" | tr A-Z a-z | tr '[:space:]' Z | \
tr -cs '[:alpha:]' Z | tr -s '\173-\377' Z | tr Z ' '`
echo $wlist
exit 0

# 将'strings' 命令的输出通过管道传递到多个 'tr' 命令中.
#  "tr A-Z a-z"  全部转换为小写字符.
#  "tr '[:space:]'"  转换空白字符为多个 Z.
#  "tr -cs '[:alpha:]' Z"  将非字母表字符转换为多个 Z,
#+ 然后去除多个连续的 Z.
#  "tr -s '\173-\377' Z"  把所有z后边的字符都转换为 Z.
#+ 并且去除多余重复的Z.(注意173(123 ascii "{")和377(255 ascii 最后一个字符)都是8进制)
#+ 这样处理之后, 我们所有之前需要处理的令我们头痛的字符
#+ 就全都转换为字符 Z 了.
#  最后"tr Z ' '" 将把所有的 Z 都转换为空格,
#+ 这样我们在下边循环中用到的变量 wlist 中的内容就全部以空格分隔了.

#  ****************************************************************
#  注意, 我们使用管道来将多个 'tr' 的输出传递到下一个 'tr' 时 
#+ 每次都使用了不同的参数.
#  ****************************************************************


for word in $wlist                    # 重要:
                                      # $wlist 这里不能使用双引号.
                                      # "$wlist" 不能正常工作.
                                      # 为什么不行?
do
  strlen=${#word}                     # 字符串长度.
  if [ "$strlen" -lt "$MINSTRLEN" ]   # 跳过短的字符串.
  then
    continue
  fi

  grep -Fw $word "$WORDFILE"          #  只匹配整个单词.
#      ^^^                            #  "固定字符串" 和
done  


exit $?