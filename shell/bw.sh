#!/bin/bash

# 自动换桌面背景

bwname="1.jpg"
swapname="swapname98924"
photodir=""


# do_inturn arg0
do_inturn()
{
    if [ -e "$1" ]; then
        cat $1 |
        while read line
        do
            if [ -z "$line"  ]; then  # 空行
                continue
            fi
            if [ "$line" == "$bwname" ]; then
                continue
            fi

            echo $line
            mv "$bwname" "$swapname"
            mv "$line" "$bwname"
            mv "$swapname" "$line"

            sleep 600
        done
    else
        echo "找不到文件 $1"
        exit 1
    fi
}

# main {
#cd "$2"
while [ 0 -eq 0 ]
do
    do_inturn "$1"
done

exit 0
# }
