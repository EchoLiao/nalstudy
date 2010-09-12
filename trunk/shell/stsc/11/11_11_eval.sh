#!/bin/bash
#Example 11-11. Showing the effect of eval
# 11_11_eval.sh

case "$1" in "-h" | "--help") 
echo "Usage: ${0##*/}";
echo "Example 11-11. Showing the effect of eval";
echo "eval的用法, 及不echo出换行符的方法."
exit $E_PARAM;;  # 没有命令行参数,
esac

y=`eval ls -l`  #  Similar to y=`ls -l`
echo $y         #+ but linefeeds removed because "echoed" variable is unquoted.
echo
# 若加"", 则输出换行符!!!!!
echo "$y"       #  Linefeeds preserved when variable is quoted.

echo; echo

y=`eval df`     #  Similar to y=`df`
echo $y         #+ but linefeeds removed.
echo
echo "==========================================================="
echo
echo "$y"

#  When LF's not preserved, it may make it easier to parse output,
#+ using utilities such as "awk".

echo
echo "==========================================================="
echo

# Now, showing how to "expand" a variable using "eval" . . .
# 不用"", 也可以输出换行符! 
for i in 1 2 3 4 5; do
  eval value=$i
  #  value=$i has same effect. The "eval" is not necessary here.
  #  A variable lacking a meta-meaning evaluates to itself --
  #+ it can't expand to anything other than its literal self.
  echo $value 
done

echo
echo "---"
echo

for i in ls df; do
  value=eval $i
  #  value=$i has an entirely different effect here.
  #  The "eval" evaluates the commands "ls" and "df" . . .
  #  The terms "ls" and "df" have a meta-meaning,
  #+ since they are interpreted as commands,
  #+ rather than just character strings.
  echo $value
done


exit 0
