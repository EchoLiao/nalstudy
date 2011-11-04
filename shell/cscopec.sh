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


cscope --version

#pwd
curpwd=`pwd -P`
#echo $curpwd
#echo $rootdir
cd /
#ls
find $curpwd -name '*.[sSchCH]' > $curpwd/cscope.files
cd $curpwd
cscope -bq
gtags -f cscope.files
