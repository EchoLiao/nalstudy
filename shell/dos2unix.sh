#!/bin/bash


case "$1" in "" | "-h" | "--help") 
    echo "Usage: ${0##*/} filename";
    echo "";
    exit $E_PARAM;;  # 没有命令行参数,
esac

mv "$1" $1.bak.bak.bak
dos2unix -k -n $1.bak.bak.bak  $1   #(^ 转换为unix格式 ^)
rm $1.bak.bak.bak
