#!/bin/bash
# Example 12-42. 按月偿还贷款
# monthlypmt.sh: 计算按月偿还贷款的数量.
# 
# bc
#    Bash 不能处理浮点运算, 并且缺乏特定的一些操作,这些操作都是一些重要的计算功能.幸运的是, bc 可以解决这个问题.
#    bc 不仅仅是个多功能灵活的精确的工具, 而且它还提供许多编程语言才具备的一些方便的功能.
#    bc 比较类似于 C 语言的语法.
#    因为它是一个完整的 UNIX 工具, 所以它可以用在管道中, bc 在脚本中也是很常用的.
#    这里有一个简单的使用 bc 命令的模版可以用来在计算脚本中的变量. 用在命令替换 中.
#                   variable=$(echo "OPTIONS; OPERATIONS" | bc)
#    	      
#  这份代码是一份修改版本, 原始版本在 "mcalc" (贷款计算)包中,
#+ 这个包的作者是 Jeff Schmidt 和 Mendel Cooper (本书作者).
#   http://www.ibiblio.org/pub/Linux/apps/financial/mcalc-1.6.tar.gz  [15k]

case "$1" in "-h" | "--help") 
echo "Usage: ${0##*/}";
echo " Example 12-42. 按月偿还贷款";
echo "bc: 精确计算数值"
exit $E_PARAM;;  # 没有命令行参数,
esac

echo
echo "Given the principal, interest rate, and term of a mortgage,"
echo "calculate the monthly payment."

bottom=1.0

echo
echo -n "Enter principal(本金) (no commas) "
read principal
echo -n "Enter interest rate(利息)(如: 是12%,那就键入12) "  # 如果是 12%, 那就键入 "12", 别输入 ".12".
read interest_r
echo -n "Enter term (months) "
read term


 interest_r=$(echo "scale=9; $interest_r/100.0" | bc) # 转换成小数.
                 # "scale" 指定了有效数字的个数.
  

 interest_rate=$(echo "scale=9; $interest_r/12 + 1.0" | bc)
 

 top=$(echo "scale=9; $principal*$interest_rate^$term" | bc)

 echo; echo "Please be patient. This may take a while."

 let "months = $term - 1"
# ==================================================================== 
 for ((x=$months; x > 0; x--))
 do
   bot=$(echo "scale=9; $interest_rate^$x" | bc)
   bottom=$(echo "scale=9; $bottom+$bot" | bc)
#  bottom = $(($bottom + $bot"))
 done
# ==================================================================== 

# -------------------------------------------------------------------- 
#  Rick Boivie 给出了一个对上边循环的修改,
#+ 这个修改更加有效率, 将会节省大概 2/3 的时间.

# for ((x=1; x <= $months; x++))
# do
#   bottom=$(echo "scale=9; $bottom * $interest_rate + 1" | bc)
# done


#  然后他又想出了一个更加有效率的版本,
#+ 将会节省 95% 的时间!

# bottom=`{
#     echo "scale=9; bottom=$bottom; interest_rate=$interest_rate"
#     for ((x=1; x <= $months; x++))
#     do
#          echo 'bottom = bottom * interest_rate + 1'
#     done
#     echo 'bottom'
#     } | bc`       # 在命令替换中嵌入一个 'for 循环'.
# --------------------------------------------------------------------------
#  On the other hand, Frank Wang suggests:
#  bottom=$(echo "scale=9; ($interest_rate^$term-1)/($interest_rate-1)" | bc)

#  因为 . . .
#  在循环后边的算法
#+ 事实上是一个等比数列的求和公式.
#  求和公式是 e0(1-q^n)/(1-q),
#+ e0 是第一个元素 并且 q=e(n+1)/e(n)
#+ 和 n 是元素的数量.
# --------------------------------------------------------------------------


 # let "payment = $top/$bottom"
 payment=$(echo "scale=2; $top/$bottom" | bc)
 # 使用2位有效数字来表示美元和美分.
 
 echo
 echo "monthly payment = \$$payment"  # 在总和的前边显示美元符号.
 echo


 exit 0


 # 练习:
 #   1) 处理输入允许本金总数中的逗号.
 #   2) 处理输入允许按照百分号和小数点的形式输入利率.
 #   3) 如果你真正想好好编写这个脚本,
 #      那么就扩展这个脚本让它能够打印出完整的分期付款表.
