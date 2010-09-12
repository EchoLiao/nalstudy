#!/bin/bash
curpwd=$PWD
cd /

find $curpwd -name '*.sql' > $curpwd/cscope.files

cd $curpwd
cscope -kbq
