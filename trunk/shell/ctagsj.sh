#!/bin/bash

hb=0
hw=0

curpwd=$PWD

if [ -e $curpwd/build ]; then
    hb=1
    mv $curpwd/build /tmp
fi
if [ -e $curpwd/war ]; then
    hw=1
    mv $curpwd/war /tmp
fi


ctags -R --java-kinds=+p --fields=+iaS --extra=+q .


if [ $hb -eq 1 ]; then
    mv /tmp/build $curpwd
fi
if [ $hw -eq 1 ]; then
    mv /tmp/war $curpwd
fi

exit 0
