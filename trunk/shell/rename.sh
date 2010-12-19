#!/bin/bash


Help()
{
echo
printf "`basename $0` - 批量修改文件名\n"
printf "Usage: `basename $0` [-h] [-a] [-d dir] [-i ifix] [-o ofix] [-p pre]\n"
printf -- "\t-h       help\n"
printf -- "\t-a       也修改基本文件名\n"
printf -- "\t-d dir   目标目录\n"
printf -- "\t-i ifix  要修改的文件名的扩展名\n"
printf -- "\t-o ofix  修改后的文件名的扩展名\n"
printf -- "\t-p pre   新文件名的开始字段\n"
printf -- "\t-n num   新文件名的数字编号的位数(默认为3位)\n"
echo
echo "Examples: 把dir目录下的所有*.png文件重新命名为liao_*.svg"
echo "rename.sh -i png -o svg -a -p liao -d dir"
echo
}


# shift命令使位置参数都左移一位.
#   $1 <--- $2, $2 <--- $3, $3 <--- $4, 以此类推.
#   原来旧的$1值会消失, 但是$0 (脚本名称)不会改变.

# "$1"为空?
until [ -z "$1" ] # until (keyline)
do
    case $sk in
        1)      shift; sk=0; continue;; # shift (keyword)
    esac
    case "$1" in
        -a)          alsorn=$1; sk=1 ;;
        -d)     shift;  dir=$1; sk=1 ;;
        -i)     shift; ifix=$1; sk=1 ;;
        -o)     shift; ofix=$1; sk=1 ;;
        -p)     shift;  pre=$1; sk=1 ;;
        -n)     shift;  num=$1; sk=1 ;;
        -h)     Help; exit 1 ;;
         *)     echo "Unknown option: $1"; Help; exit 1 ;;
    esac
done

dir=${dir:-"."}
ifix=${ifix:-"*"}
pre=${pre:-""}
num=${num:-3}
#echo "-a$alsorn -d$dir -i$ifix -o$ofix -p$pre"

#
if [[ ! $alsorn  &&  ! $ofix && ! $pre ]]; then
    echo "Nothing to do!"
    exit 1
fi

# 进入目标目录
cd $dir
if [ "$?" -ne 0 ]; then
    echo "cd faild!"
    exit 128
fi

# ${string##substring}	Strip longest match of $substring from front of $string
# ${string%substring}	Strip shortest match of $substring from back of $string
count=1
for file in ./*.$ifix; do # 遍历目录 (keyline)
    if [ ! -e "$file" ]; then continue; fi

    file=${file##*/} # 只保留最短的文件名

    # 生成新的基本文件名
    if [ $alsorn ]; then
        newname=`printf %0*d $num $count` # "*" 动态指定数字的位数. (keyline)
    else
        newname=${file%.*} # 用原来的基本文件名(即只改扩展名)
    fi

    if [ $pre ]; then
        newname=$pre""$newname
    fi

    # 确定扩展名
    if [ ! $ofix ]; then
        ofix=$ifix
    fi

    if [[ "$file" != "$newname.$ofix" ]]; then
        mv "$file" "$newname.$ofix"
    else
        echo "$file equality name $newname.$ofix"
    fi

    ((count++))
done

exit 0
