#!/bin/bash

# 推算系统是什么时候启动的.
echo -n "system boot time : "
date -d "$(awk -F. '{print $1}' /proc/uptime) second ago" +"%Y-%m-%d %H:%M:%S"

echo -n "had up           : "
#uptime | awk '{print $3,$4}' | tr ',' ' '
cat /proc/uptime | awk -F. '{run_days=$1 / 86400;run_hour=($1 % \
    86400)/3600;run_minute=($1 % 3600)/60;run_second=$1 % 60; \
    printf("%ddays %dhours %dminutes %dseconds\n", run_days, run_hour, \
    run_minute, run_second)}'

echo -n "now time         : "
date

exit 0
