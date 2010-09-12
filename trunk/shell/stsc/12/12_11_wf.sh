#!/bin/bash
#Example 12-11. 分析单词出现的频率
# wf.sh: 分析文本文件中自然词汇出现的频率.
# "wf2.sh" 是一个效率更高的版本.

# 从命令行中检查输入的文件.
E_BADARGS=65
E_NOFILE=66

case "$1" in "-h" | "--help") 
echo "Usage: `basename $0` filename"
echo "sed; sort; uniq; tr"
exit $E_BADARGS
esac

if [ ! -f "$1" ]       # 检查传入的文件参数是否存在.
then
  echo "File \"$1\" does not exist."
  exit $E_NOFILE
fi

########################################################
# main ()
sed -e 's/\.//g'  -e 's/\,//g' -e 's/  */\ /g' -e 's/  *$/\ /g' \
"$1" | tr 'A-Z' 'a-z' | sort | uniq -c | sort -nr

#sed -e 's/\.//g'  -e 's/\,//g' -e 's/ /\
#/g' "$1" | tr 'A-Z' 'a-z' | sort | uniq -c | sort -nr	 # OOOOO
#                           =========================
#                               检查单词出现的频率

#  过滤掉句号和逗号,
#+ 并且把单词间的空格转化为换行,
#+ 然后转化为小写,
#+ 最后统计出现的频率并按频率排序.

#  Arun Giridhar 建议将上边的代码修改为:
#  . . . | sort | uniq -c | sort +1 [-f] | sort +0 -nr
#  这句添加了第2个排序主键, 所以
#+ 这个与上边等价的例子将按照字母顺序进行排序.
#  就像他所解释的:
#  "这是一个有效的根排序, 首先对频率最少的
#+ 列进行排序
#+ (单词或者字符串, 忽略大小写)
#+ 然后对频率最高的列进行排序."
#
#  像 Frank Wang 所解释的那样, 上边的代码等价于:
#+       . . . | sort | uniq -c | sort +0 -nr
#+ 用下边这行也行:
#+       . . . | sort | uniq -c | sort -k1nr -k
########################################################

exit 0

# 练习:
# -----
# 1) 使用 'sed' 命令来过滤其他的标点符号,
#+   比如分号.
# 2) 修改这个脚本, 添加能够过滤多个空格或者
#    空白的能力.
