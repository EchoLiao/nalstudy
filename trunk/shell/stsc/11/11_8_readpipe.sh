#!/bin/sh
#Example 11-8. Problems reading from a pipe
# 11_8_readpipe.sh
# This example contributed by Bjon Eriksson.

case "$1" in "-h" | "--help") 
echo "Usage: ${0##*/}";
echo "Example 11-8. Problems reading from a pipe";
echo "用read从管道读取时, 输出的所有行都被包含在{ }之间!"
exit $E_PARAM;;  # 没有命令行参数,
esac

last="(null)"
# 通过管道
cat $0 | # 读出的所有的行都被包含在{ }之间! 
while read line
do
    echo "{$line}"
    last=$line
done
printf "\nAll done, last:$last\n"

exit 0  # End of code.
        # (Partial) output of script follows.
        # The 'echo' supplies extra brackets.
