#!/bin/bash

#
# 用于在目录(/home/sre/.rt/book/html)下生成可读的标签
#

tmp_list="tmp3298324"
dir_list="dir_list"
tagf="README.tag.txt"
nr=0



function rd_ct()  # move filenames to lowercase
{
    find . -maxdepth 1 -type d | sed '1d' > $dir_list

    truncate --size 0 $tagf
    cat $dir_list |
    while read line
    do
        ((nr++))
        #echo "$nr. ${line#*/}" >> $tagf
        printf "%02d. %s\n" $nr ${line#*/} >> $tagf
        rdf=$line/README
        if [ -e $rdf ]; then
            cat $rdf |
            while read rline
            do
                echo -e "\t$rline" >> $tagf
            done
        fi
        echo "" >> $tagf
    done
}

# main {
rd_ct

rm -f $tmp_list
rm -f $dir_list
# }

exit 0
