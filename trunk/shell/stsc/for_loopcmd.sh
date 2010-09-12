#!/bin/bash
#  for_loopcmd.sh: 带[list]的for循环
#例子10-6. 使用命令替换来产生for循环的[list]

#+ [list]是由命令替换产生的.

NUMBERS="9 7 3 8 37.53"

for number in `echo $NUMBERS`  # for number in 9 7 3 8 37.53
do
  echo -n "$number "
done

echo 
exit 0
