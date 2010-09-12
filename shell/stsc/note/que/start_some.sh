#!/bin/bash

#批量启动进程

if [ $# -lt "4" ]
then
    echo usage: process port username_start username_stop
fi

name=$1
i=$3
j=$4
port=$2

while(( i < j ))
do
    $name $port user$i arg1 arg2 &
    ((i++))
    ((port++))
done
