#!/bin/bash
#例子 10-16. 多条件的while循环

var1=unset
previous=$var1

while echo "previous-variable = $previous"
      echo
      previous=$var1
      [ "$var1" != end ] # 记录之前的$var1.
      # 这个"while"循环中有4个条件, 但是只有最后一个能控制循环.
      # 退出状态由第4个条件决定.
do
echo "Input variable #1 (end to exit) "
  read var1
  echo "variable #1 = $var1"
done  

# 尝试理解这个脚本的运行过程.
# 这里还是有点小技巧的.

exit 0
