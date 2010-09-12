#!/bin/bash
#Example 12-57. 将英里转换为米
# unit_conversion.sh

case "$1" in "" | "-h" | "--help") 
echo "Usage: ${0##*/}";
echo "Example 12-57. 将英里转换为米";
echo ""
exit $E_PARAM;;  # 没有命令行参数,
esac


# 求换算公式 1 miles = x meters
convert_units ()  # 通过参数取得需要转换的单位.
{
    # sed --silent -e '1p' ==> 只打印出第一行
    cf=$(units "$1" "$2" | sed --silent -e '1p' | awk '{print $2}')
    # 除了真正需要转换的部分保留下来外,其他的部分都去掉.
    echo "$cf"	# 返回值: x
}  

Unit1=miles
Unit2=meters
cfactor=`convert_units $Unit1 $Unit2`
quantity=$1

result=$(echo $quantity*$cfactor | bc)

echo "There are $result $Unit2 in $quantity $Unit1."

#  如果你传递了两个不匹配的单位会发生什么?
#+ 比如分别传入英亩和英里?

exit 0
