#!/bin/bash
# list-glob.sh:  在for循环中使用文件名扩展产生 [list]
例子 10-4. 在for循环中操作文件


echo

for file in *
#           ^  在表达式中识别文件扩展符时,
#+             Bash 将执行文件名扩展.
do
  ls -l "$file"  # Lists all files in $PWD (current directory).
  #  回想一下,通配符"*"能够匹配所有文件,
  #+ 然而,在"文件扩展符"中,是不能匹配"."文件的.

  #  如果没匹配到任何文件,那它将扩展成自己
  #  为了不让这种情况发生,那就设置nullglob选项
  #+   (shopt -s nullglob).
  #  Thanks, S.C.
done

echo; echo

for file in [jx]*
do
  rm -f $file    # 只删除当前目录下以"j"或"x"开头的文件.
  echo "Removed file \"$file\"".
done

echo

exit 0

在一个for循环中忽略in [list]部分的话,将会使循环操作$@(从命令行传递给脚本的参数列表).一个非常好的例子,见例子 A-16.
