#!/bin/bash


read_line()
{
if [ -e "$1" ]; then
    cat $1 |
    while read line
    do
	#readline=`echo $line | awk '{ print $1 }'`
	readline=$line
	if [ -z "$readline"  ]; then  # 空行
	    continue
	fi
	echo -n "$readline	"
	/home/scr/bin/sdcv.sh "\"$readline\""
    done
fi
}

# main {
read_line $1
# }
