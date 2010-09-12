#!/bin/bash
#Example 11-25. A script that kills itself
# self_destruct.sh

case "$1" in "-h" | "--help") 
echo "Usage: ${0##*/}";
echo "Example 11-25. A script that kills itself";
echo "\$$  # Script-self"
exit $E_PARAM;;  # 没有命令行参数,
esac

kill $$  # Script kills its own process here.
         # Recall that "$$" is the script's PID.

echo "This line will not echo."
# Instead, the shell sends a "Terminated" message to stdout.

exit 0

#  After this script terminates prematurely,
#+ what exit status does it return?
#
# sh self-destruct.sh
# echo $?
# 143
#
# 143 = 128 + 15
#             TERM signal
