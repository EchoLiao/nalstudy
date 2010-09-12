#!/bin/bash
#Example 11-16. reassigning the positional parameters

case "$1" in "-h" | "--help") 
echo "Usage: ${0##*/}";
echo "Example 11-16. reassigning the positional parameters";
echo
echo "variable=\"one two three four five\""
echo "set -- \$variable	#把variable的各个值(以空格隔开)设置为命令行的参数."
exit $E_PARAM;;  # 没有命令行参数,
esac

variable="one two three four five"

set -- $variable
# Sets positional parameters to the contents of "$variable".

first_param=$1
second_param=$2
shift; shift        # Shift past first two positional params.
remaining_params="$*"

echo
echo "first parameter = $first_param"             # one
echo "second parameter = $second_param"           # two
echo "remaining parameters = $remaining_params"   # three four five

echo; echo

# Again.
set -- $variable
first_param=$1
second_param=$2
echo "first parameter = $first_param"             # one
echo "second parameter = $second_param"           # two

# ======================================================

set --
# Unsets positional parameters if no variable specified.

first_param=$1
second_param=$2
echo "first parameter = $first_param"             # (null value)
echo "second parameter = $second_param"           # (null value)

exit 0

