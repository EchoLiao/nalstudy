#!/bin/bash

# ./find_bn.awk in

if [[ $# < 1 || "$1" == "-h" ]]; then
    echo
    echo `basename $0` - 在一系列的连续数字找出中断的数字
    echo Usage: `basename $0` infile
    echo
    exit 1
fi


awk -F. '
# load acronyms file into array "acro"
# FILENAME == "i" {
{
    # split($0,entry,".")
    gsub(" ", "", $1)
    acro[++idx]=$1

    # printf("%s : %s\n", idx, acro[idx])

    next
}

END {
    print idx
    # for ( idx in acro ) {
    for ( i=2; i < idx; i++ ) {
        if ( acro[i] != acro[i-1] + 1 )
            print acro[i-1] + 1
    }
}

' $*
