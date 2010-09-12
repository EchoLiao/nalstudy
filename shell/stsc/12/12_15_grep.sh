#!/bin/bash
#Example 12-15. 在一个脚本中模仿 "grep" 的行为
# grep.sh: 一个非常粗糙的 'grep' 的实现.

case "$1" in "-h" | "--help") 
echo "Usage: ${0##*/}";
echo "Example 12-15. 在一个脚本中模仿 "grep" 的行为";
echo "for; continue; sed"
exit $E_PARAM;;  # 没有命令行参数,
esac

E_BADARGS=65

if [ -z "$1" ]    # 检查传递给脚本的参数.
then
  echo "Usage: `basename $0` pattern"
  exit $E_BADARGS
fi  

echo

for file in *     # 遍历 $PWD 下的所有文件.
do
  if [ ! -f $file ]; then continue; fi
  output=$(sed -n /"$1"/p $file)  # 命令替换.
  if [ ! -z "$output" ]           # 如果"$output" 不加双引号将会发生什么?
  then
    echo -n "$file:   "
    echo $output
	echo
  fi              #  sed -ne "/$1/s|^|${file}: |p"  这句与上边这段等价.
done  

echo

exit 0

# 练习:
# -----
# 1) 在任何给定的文件中,如果有超过一个匹配的话, 在输出中添加新行.
# 2) 添加一些特征.
