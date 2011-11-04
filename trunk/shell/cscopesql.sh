#!/bin/bash
curpwd=`pwd -P`
cd /

find $curpwd -name '*.sql' > $curpwd/cscope.files

cd $curpwd
cscope -kbq
gtags -f cscope.files
