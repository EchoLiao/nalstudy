#!/bin/bash

#  在SHELL程序中实现'按任意键继续'
#  注: man stty 

get_char()
{
    SAVEDSTTY=`stty -g`
    stty -echo
    stty raw
    dd if=/dev/tty bs=1 count=1 2> /dev/null
    stty -raw
    stty echo
    stty $SAVEDSTTY
}

echo "Press any key to continue..."
char=`get_char` 
echo $char
