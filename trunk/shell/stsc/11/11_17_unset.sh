#!/bin/bash
#Example 11-17. "Unsetting" a variable
# unset.sh: Unsetting a variable.

case "$1" in "-h" | "--help") 
echo "Usage: ${0##*/}";
echo "Example 11-17. "Unsetting" a variable";
echo "unset"
exit $E_PARAM;;  # 没有命令行参数,
esac

variable=hello                       # Initialized.
echo "variable = $variable"

unset variable                       # Unset.
                                     # Same effect as:  variable=
echo "(unset) variable = $variable"  # $variable is null.

exit 0
