#!/bin/bash
#例子 10-21. 多层循环的退出
# break_levels.sh: 退出循环.

# "break N" 退出N层循环.

for outerloop in 1 2 3 4 5
do
  echo -n "Group $outerloop:   "

  # --------------------------------------------------------
  for innerloop in 1 2 3 4 5
  do
    echo -n "$innerloop "

    if [ "$innerloop" -eq 3 ]
    then
      break  # 试试 break 2 来看看发生什么.
             # (里面一层循环和外面一层循环都被退出了..)
	  #break 2
    fi
  done
  # --------------------------------------------------------

  echo
done  

echo

exit 0
