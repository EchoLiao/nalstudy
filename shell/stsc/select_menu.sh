#!/bin/bash
#例子 10-30. 用函数中select结构来创建菜单

case "$1" in "-h" | "--help") 
echo "Usage: ${0##*/}";
echo "例子 10-30. 用函数中select结构来创建菜单";
exit $E_PARAM;;  # 没有命令行参数,
esac

PS3='Choose your favorite vegetable: '

echo

choice_of()
{
select vegetable
# [in list] 被忽略, 所以'select'用传递给函数的参数.
do
  echo
  echo "Your favorite veggie is $vegetable."
  echo "Yuck!"
  echo
  break
done
}

choice_of beans rice carrots radishes tomatoes spinach
#         $1    $2   $3      $4       $5       $6
#         传递给choice_of() 函数的参数

exit 0
