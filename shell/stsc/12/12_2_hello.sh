#!/bin/bash
#Example 12-2. Hello or Good-bye
# hello.sh: 显示"hello" 还是 "goodbye", 依赖于脚本是如何被调用的.

case "$1" in "-h" | "--help") 
echo "Usage: ${0##*/}";
echo "显示"hello" 还是 "goodbye", 依赖于脚本是如何被调用的.";
exit $E_PARAM;;  # 没有命令行参数,
esac

# 在当前目录下($PWD)为这个脚本创建一个链接:
#    ln -s hello.sh goodbye
# 现在, 通过如下两种方法来调用这个脚本:
# ./hello.sh
# ./goodbye


HELLO_CALL=65
GOODBYE_CALL=66

if [ $0 = "./goodbye" ]
then
  echo "Good-bye!"
  # 当然, 在这里你也可以添加一些其他的 goodbye类型的命令.Some other goodbye-type commands, as appropriate.
  exit $GOODBYE_CALL
fi

echo "Hello!"
# 当然, 在这里你也可以添加一些其他的 hello类型的命令.
exit $HELLO_CALL
