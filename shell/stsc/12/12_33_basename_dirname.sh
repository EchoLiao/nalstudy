#!/bin/bash
#Example 12-33. basename 和 dirname

case "$1" in "-h" | "--help") 
echo "Usage: ${0##*/}";
echo "Example 12-33. basename 和 dirname";
echo "basename; dirname"
exit $E_PARAM;;  # 没有命令行参数,
esac

a=/home/bozo/daily-journal.txt

echo "Basename of /home/bozo/daily-journal.txt = `basename $a`"
echo "Dirname of /home/bozo/daily-journal.txt = `dirname $a`"
echo
echo "My own home is `basename ~/`"         # `basename ~` also works.
echo "The home of my home is `dirname ~/`"  # `dirname ~`  also works.

exit 0
