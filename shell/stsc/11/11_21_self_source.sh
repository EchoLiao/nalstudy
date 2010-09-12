#!/bin/bash
#Example 11-21. A (useless) script that sources itself
# self_source.sh: a script sourcing itself "recursively."
# From "Stupid Script Tricks," Volume II.

case "$1" in "-h" | "--help") 
echo "Usage: ${0##*/}";
echo "Example 11-21. A (useless) script that sources itself";
echo "source与call的区别"
exit $E_PARAM;;  # 没有命令行参数,
esac

MAXPASSCNT=100    # Maximum number of execution passes.

echo -n  "$pass_count  " # $pass_count没任何东西!
#  At first execution pass, this just echoes two blank spaces,
#+ since $pass_count still uninitialized.

let "pass_count += 1" # 在这之前最好初始化pass_count, 但应该怎么初始化呢?????
#  Assumes the uninitialized variable $pass_count
#+ can be incremented the first time around.
#  This works with Bash and pdksh, but
#+ it relies on non-portable (and possibly dangerous) behavior.
#  Better would be to initialize $pass_count to 0 before incrementing.

while [ "$pass_count" -le $MAXPASSCNT ]
do
	# 若改成 ./$0 , 则变成每次运行一个新的script(即: $0).
  . $0   # Script "sources" itself, rather than calling itself.
         # ./$0 (which would be true recursion) doesn't work here. Why?
done

#  What occurs here is not actually recursion,
#+ since the script effectively "expands" itself, i.e.,
#+ generates a new section of code
#+ with each pass through the 'while' loop',
#  with each 'source' in line 20.
#
#  Of course, the script interprets each newly 'sourced' "#!" line
#+ as a comment, and not as the start of a new script.

echo

exit 0   # The net effect is counting from 1 to 100.
         # Very impressive.

# Exercise:
# --------
# Write a script that uses this trick to actually do something useful.
