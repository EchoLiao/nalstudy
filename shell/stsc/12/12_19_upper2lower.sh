#!/bin/bash
#Example 12-19. 转换小写: 将当前目录下的所有文件名或目录名全部转换为小写.
#

case "$1" in "-h" | "--help") 
echo "Usage: ${0##*/}";
echo "Example 12-19. 转换小写: 将当前目录下的所有文件名或目录名全部转换为小写.";
echo "echo \"\$filename/\""
exit $E_PARAM;;  # 没有命令行参数,
esac

#for filename in *                # 遍历当前目录下的所有文件.
#do
   #fname=`basename $filename`
   #n=`echo $fname | tr A-Z a-z`  # 将名字修改为小写.
   #if [ "$fname" != "$n" ]       # 只对那些文件名不是小写的文件进行重命名.
   #then
     #mv $fname $n
   #fi  
#done   
#exit $?


# 下边的代码将不会被执行, 因为上边的 "exit".
#-------------------------------------------#
# 删除上边的内容,来运行下边的内容.

# 对于那些文件名中包含空白和新行的文件, 上边的脚本就不能工作了.
# Stephane Chazelas 因此建议使用下边的方法:

for filename in *    # 不必非得使用 basename 命令,
                     # 因为 "*" 不会返回任何包含 "/" 的文件.
do n=`echo "$filename/" | tr '[:upper:]' '[:lower:]'`
#                             POSIX 字符集标记法.
#                    添加的斜线是为了在文件名结尾换行不会被
#                    命令替换删掉.
   # 变量替换:
   n=${n%/}          # 从文件名中将上边添加在结尾的斜线删除掉.
   if [[ "$filename" != $n ]]; then echo $n; fi

   [[ $filename == $n ]] || mv "$filename" "$n"
                     # 检查文件名是否已经是小写.
done

exit $?
