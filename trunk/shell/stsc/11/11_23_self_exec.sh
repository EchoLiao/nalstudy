#!/bin/bash
#Example 11-23. A script that exec's itself
# self_exec.sh

case "$1" in "-h" | "--help") 
echo "Usage: ${0##*/}";
echo "Example 11-23. A script that exec's itself";
echo "exec"
exit $E_PARAM;;  # 没有命令行参数,
esac

echo

echo "This line appears ONCE in the script, yet it keeps echoing."
echo "The PID of this instance of the script is still $$."
#     Demonstrates that a subshell is not forked off.

echo "==================== Hit Ctl-C to exit ===================="

sleep 1

exec $0   #  Spawns another instance of this same script
          #+ that replaces the previous one.

echo "This line will never echo!"  # Why not?

exit 0
