#!/bin/bash
#Example 11-15. Using set with positional parameters

# script "set_test"

# Invoke this script with three command line parameters,
# for example, "./set-test one two three".

case "$1" in "-h" | "--help") 
echo "Usage: ${0##*/}";
echo "Example 11-15. Using set with positional parameters";
echo "用set命令设置命令参数."
echo "echo \$_   #重复输出最后一次echo所输出的字符串!"
exit $E_PARAM;;  # 没有命令行参数,
esac

echo
echo "Positional parameters before  set \`uname -a\` :"
echo "Command-line argument #1 = $1"
echo "Command-line argument #2 = $2"
echo "Command-line argument #3 = $3"


set `uname -a` # Sets the positional parameters to the output
               # of the command `uname -a`

echo $_        # unknown   重复输出最后一次echo所输出的字符串!
# Flags set in script.

echo "Positional parameters after  set \`uname -a\` :"
# $1, $2, $3, etc. reinitialized to result of `uname -a`
echo "Field #0 of 'uname -a' = $0"
echo "Field #1 of 'uname -a' = $1"
echo "Field #2 of 'uname -a' = $2"
echo "Field #3 of 'uname -a' = $3"
echo "Field #4 of 'uname -a' = $4"
echo ---
echo $_        # ---
echo

exit 0
