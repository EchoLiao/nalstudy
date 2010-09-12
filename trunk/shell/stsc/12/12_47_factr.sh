#!/bin/bash
#Example 12-47. 因子分解
# factr.sh: 分解约数

MIN=2       # 如果比这个数小就不行了.
E_NOARGS=65
E_TOOSMALL=66

if [ -z $1 -o "$1" == "-h" ]
then
  echo "Usage: $0 number"
  echo "分解约数"
  exit $E_NOARGS
fi

if [ "$1" -lt "$MIN" ]
then
  echo "Number to factor must be $MIN or greater."
  exit $E_TOOSMALL
fi  

# 练习: 添加类型检查 (防止非整型的参数).

echo "Factors of $1:"
# ---------------------------------------------------------------------------------
echo "$1[p]s2[lip/dli%0=1dvsr]s12sid2%0=13sidvsr[dli%0=1lrli2+dsi!>.]ds.xd1<2" | dc
# ---------------------------------------------------------------------------------
# 上边这行代码是 Michel Charpentier 编写的<charpov@cs.unh.edu>.
# 在此使用经过授权 (thanks).

 exit 0
