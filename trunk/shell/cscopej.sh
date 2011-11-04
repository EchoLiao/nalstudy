#!/bin/bash
#cls
#@echo on
#dir cscope.*
#del cscope.*
#del ncscope.*
#dir cscope.*
#call bk.bat
#dir /s /b *.java > cscope.files
#REM cscope -b -q -k -i cscope.files
#cscope -b
#dir cscope.*



hb=0
hw=0

curpwd=`pwd -P`

if [ -e $curpwd/build ]; then
    hb=1
    mv $curpwd/build /tmp
fi
if [ -e $curpwd/war ]; then
    hw=1
    mv $curpwd/war /tmp
fi


cd /
find $curpwd -name '*.java' -or -name '*.jsp' -or -name '*.xml' -or \
    -name '*.html' -or -name '*.htm' -or -name '*.tld' -or -name README \
    > $curpwd/cscope.files

cd $curpwd
cscope -bq
gtags -f cscope.files


if [ $hb -eq 1 ]; then
    mv /tmp/build $curpwd
fi
if [ $hw -eq 1 ]; then
    mv /tmp/war $curpwd
fi

exit 0
