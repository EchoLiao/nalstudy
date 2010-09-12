#!/bin/bash
#例子 10-14. 简单的while循环

var0=0
LIMIT=10

while [ "$var0" -lt "$LIMIT" ] # -lt: 小于;  -le: 小于等于
do
  echo -n "$var0 "        # -n 将会阻止产生新行.
  #             ^           空格,数字之间的分隔.

  var0=`expr $var0 + 1`   # var0=$(($var0+1))  也可以.
                          # var0=$((var0 + 1)) 也可以.
                          # let "var0 += 1"    也可以.
done                      # 使用其他的方法也行.

echo

exit 0
