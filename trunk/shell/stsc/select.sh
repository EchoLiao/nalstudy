#!/bin/bash
#例子 10-29. 用select来创建菜单

case "$1" in "-h" | "--help") 
echo "Usage: ${0##*/}";
echo "例子 10-29. 用select来创建菜单";
exit $E_PARAM;;  # 没有命令行参数,
esac

# PS3是select内置变量?
PS3='Choose your favorite vegetable: ' # 设置提示符字串.

echo
select vegetable in "beans" "carrots" "potatoes" "onions" "rutabagas"
do
  echo
  echo "Your favorite veggie is $vegetable."
  echo "Yuck!"
  echo
  break  # 如果这里没有'break'会发生什么?
done

exit 0
