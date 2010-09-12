#!/bin/bash
#Example 11-4. What happens when read has no variable
# read_novar.sh

case "$1" in "-h" | "--help") 
echo "Usage: ${0##*/}";
echo "Example 11-4. What happens when read has no variable";
echo "read的内置变量REPLY."
exit $E_PARAM;;  # 没有命令行参数,
esac
echo

# -------------------------- #
echo -n "Enter a value: "
read var
echo "\"var\" = "$var""
# Everything as expected here.
# -------------------------- #

echo

# ------------------------------------------------------------------- #
echo -n "Enter another value: "
read           #  No variable supplied for 'read', therefore...
               #+ Input to 'read' assigned to default variable, $REPLY.
var="$REPLY"
echo "\"var\" = "$var""
# This is equivalent to the first code block.
# ------------------------------------------------------------------- #

echo

exit 0
