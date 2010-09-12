#! /bin/bash
#这是一个更容易懂的命令行参数处理的一个例子：

while [ $# -gt 0 ]; do    # 直到你用完所有的参数...
  case "$1" in
    -d|--debug)
              # 是"-d" 或 "--debug" 参数吗?
              DEBUG=1
              ;;
    -c|--conf)
              CONFFILE="$2"
              shift
              if [ ! -f $CONFFILE ]; then
                echo "Error: Supplied file doesn't exist!"
                exit $E_CONFFILE     # 文件没发现错误.
              fi
              ;;
  esac
  shift       # 检查剩下的参数.
done

#  来自Stefano Falsetto的 "Log2Rot" 脚本,
#+ 他的"rottlog" 包的一部分.
#  已得到使用许可
