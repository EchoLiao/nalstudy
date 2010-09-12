#!/bin/bash
#例子 10-22. 多层循环的continue
# "continue N" 命令, 将让N层的循环全部被continue.

for outer in I II III IV V           # 外部循环
do
  echo; echo -n "Group $outer: "

  # --------------------------------------------------------------------
  for inner in 1 2 3 4 5 6 7 8 9 10  # 内部循环
  do

    if [ "$inner" -eq 7 ]
    then
      continue 2  # continue 2层, 也就是到outer循环上.
                  # 将"continue 2"替换为一个单独的"continue"
                  # 来看一下一个正常循环的行为.
    fi  

    echo -n "$inner "  # 7 8 9 10 将不会被echo
  done  
  # --------------------------------------------------------------------
#译者注:如果在此处添加echo的话,当然也不会输出.
done

echo; echo

# 练习:
# 准备一个有意义的"continue N"的使用,放在脚本中.

exit 0
