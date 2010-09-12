#!/bin/bash
#Example 11-3. Variable assignment, using read
# "Reading" variables.

case "$1" in "-h" | "--help") 
echo "Usage: ${0##*/}";
echo "Example 11-3. Variable assignment, using read";
echo "read的用法."
exit $E_PARAM;;  # 没有命令行参数,
esac

echo -n "Enter the value of variable 'var1': "
# The -n option to echo suppresses newline.

read var1
# Note no '$' in front of var1, since it is being set.

echo "var1 = $var1"


echo

# A single 'read' statement can set multiple variables.
echo -n "Enter the values of variables 'var2' and 'var3' (separated by a space or tab): "
read var2 var3
echo "var2 = $var2      var3 = $var3"
# If you input only one value, the other variable(s) will remain unset (null).

exit 0
