#!/bin/bash
# @_@ QQQQQ

#  使用/etc/init.d/funtction里的函数来进行进程的启动, 状态, 停止. 开机自动打开
#+ NUMLOCK
#  参数 -D 才能改变default flags
#+ 当然如果把num换成caps, scroll就能改变capslock,scrolllock的状态 
#+ 注: man setleds


for t in `seq 1 8`
do
setleds -D +num
$t>/dev/null
done
