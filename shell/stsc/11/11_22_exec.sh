#!/bin/bash
#Example 11-22. Effects of exec

#执行exec后永远不在返回!!
exec echo "Exiting \"$0\"."   # Exit from script here.

# ----------------------------------
# The following lines never execute.

echo "This echo will never echo."

exit 99                       #  This script will not exit here.
                              #  Check exit value after script terminates
                              #+ with an 'echo $?'.
                              #  It will *not* be 99.
