#!/bin/bash
# findstring.sh:
#例子 10-9. 在目录的所有文件中查找源字串

# 在一个指定目录的所有文件中查找一个特定的字符串.

directory=/usr/bin/
fstring="Free Software Foundation"  # 查看那个文件中包含FSF.

for file in $( find $directory -type f -name '*' | sort )
do
  #strings -f $file | grep "$fstring" | sed -e "s%$directory%%"
  strings -f $file | grep "$fstring" 
  #  在"sed"表达式中,
  #+ 我们必须替换掉正常的替换分隔符"/",
  #+ 因为"/"碰巧是我们需要过滤的字串之一.
#(2010年 03月 06日 星期六 01:32:02 CST)
#=============================================================================
#在我机器上, 不用sed也可以!
  #  如果不用"%"代替"/"作为分隔符,那么这个操作将失败,并给出一个错误消息.(试试)
done  

exit 0

#  练习 (容易):
#  ---------------
#  将内部用的$directory和$fstring变量,用从
#+ 命令行参数代替.

#for循环的输出也可以通过管道传递到一个或多个命令中.
