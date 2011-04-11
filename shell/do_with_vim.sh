#!/bin/bash

chListFile="find_ch.lists"

find . -name '*.[ch]' > $chListFile

if [ -e "$chListFile" ]; then
    cat $chListFile |
    while read line
    do
        if [ -z "$line"  ]; then  # 空行
            continue
        fi
        # echo $line
        # 用vim打开并强制保存
        /usr/bin/xterm -e /usr/local/bin/vim -c 'w!' -c 'q' $line
        # /usr/bin/gnome-terminal --zoom 0.3 -e /usr/local/bin/vim -c 'w!' -c 'q' $line
    done
fi
rm -f $chListFile

exit 0
