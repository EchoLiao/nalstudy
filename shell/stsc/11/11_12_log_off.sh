#!/bin/bash
#Example 11-12. Forcing a log-off
# Killing ppp to force a 11_12_log_off.

case "$1" in "-h" | "--help") 
echo "Usage: ${0##*/}";
echo "Example 11-12. Forcing a log-off";
echo "用awk的用法"
exit $E_PARAM;;  # 没有命令行参数,
esac

# Script should be run as root user.

# awk '/ppp/ {print $1}'	表示得到ppp的进程id.
killppp="eval kill -9 `ps ax | awk '/ppp/ { print $1 }'`"
#                     -------- process ID of ppp -------  

$killppp                  # This variable is now a command.


# The following operations must be done as root user.

chmod 666 /dev/ttyS3      # Restore read+write permissions, or else what?
#  Since doing a SIGKILL on ppp changed the permissions on the serial port,
#+ we restore permissions to previous state.

rm /var/lock/LCK..ttyS3   # Remove the serial port lock file. Why?

exit 0

# Exercises:
# ---------
# 1) Have script check whether root user is invoking it.
# 2) Do a check on whether the process to be killed
#+   is actually running before attempting to kill it.   
# 3) Write an alternate version of this script based on 'fuser':
#+      if [ fuser -s /dev/modem ]; then . . .
