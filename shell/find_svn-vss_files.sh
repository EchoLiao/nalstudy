#/bin/bash

E_CHANGED_MIND=21

find . -type f | grep -w "tags"     > /dev/null;    tag=$?
find . -type f | grep "\.o$"        > /dev/null;      o=$?
find . -type f | grep "cscope\."    > /dev/null;    csc=$?
find . -type f | grep "\.swo$"      > /dev/null;    swo=$?
find . -type f | grep "\.scc$"      > /dev/null;    scc=$?
find . -type f | grep "~$"          > /dev/null;    blx=$?
find . -type f | grep "\.swp$"      > /dev/null;    swp=$?
find . -type d | grep "\.svn"       > /dev/null;    svn=$?

echo -e "tags   = $tag"
echo -e "o      = $o"
echo -e "cscope = $csc"
echo -e "swo    = $swo"
echo -e "scc    = $scc"
echo -e "~      = $blx"
echo -e "swp    = $swp"
echo -e "svn    = $svn"

echo "\$1 = $1"
[[ $1 != "-d" ]] && {
exit 0
}

echo; 
# 'rm' 命令的 '-v' 选项也会问这句话.
for ((i=0; i==0; ))
do
	echo -n "Are you absolutely sure you want to delete (y/n)? "
	read answer
	case "$answer" in
	[nN]) exit $E_CHANGED_MIND ;;
    [yY]) echo; echo -n "Deleting files ...    "; i=1;;
	   *) ;;
	esac
done


# 若带"-d"参数, 则把搜索到的文件和目录删除!
find . -type f | grep -w "tags"     | xargs rm -rf
find . -type f | grep "\.o$"        | xargs rm -rf
find . -type f | grep "cscope\."    | xargs rm -rf
find . -type f | grep "\.swo$"      | xargs rm -rf
find . -type f | grep "\.scc$"      | xargs rm -rf
find . -type f | grep "~$"          | xargs rm -rf
find . -type f | grep "\.swp$"      | xargs rm -rf
find . -type d | grep "\.svn"       | xargs rm -rf

echo "Delete done."
echo

exit 0
