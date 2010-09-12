#!/bin/bash

#例子 10-2. 每个[list]元素带两个参数的for循环
# 再访行星.

# 分配行星的名字和它距太阳的距离.

for planet in "Mercury 36" "Venus 67" "Earth 93"  "Mars 142" "Jupiter 483"
do
# Parses variable "planet" and sets positional parameters.
  set -- $planet
  # "--" 将防止$planet为空,或者是以一个破折号开头. #????? 

  # 可能需要保存原始的位置参数,因为它们被覆盖了.
  # 一种方法就是使用数组,
  #        original_params=("$@")

  echo "$1		$2,000,000 miles from the sun"
  #-------two  tabs---把后边的0和$2连接起来
done

# (Thanks, S.C., for additional clarification.)

exit 0
