#!/bin/bash
#Example 12-4. 通过文件的 inode 号来删除文件
# idelete.sh: 通过文件的inode号来删除文件.

#  当文件名以一个非法字符开头的时候, 这就非常有用了, 比如 ? 或 -.

case "$1" in "" | "-h" | "--help") 
echo "Usage: ${0##*/} filename";
echo "当文件名以一个非法字符开头的时候, 这就非常有用了, 比如 ? 或 -."
echo
echo "Example 12-4. 通过文件的 inode 号来删除文件";
echo "awk; find; ls -i; export;"
echo
exit $E_PARAM;;  # 没有命令行参数,
esac

E_FILE_NOT_EXIST=71
E_CHANGED_MIND=72

if [ ! -e "$1" ]
then
  echo "File \""$1"\" does not exist."
  exit $E_FILE_NOT_EXIST # 
fi  

#inum=`ls -i | grep "\\<$1\\>" | awk '{print $1}'` 
inum=`ls -i | grep "$1" | awk '{print $1}'` # OOOOO 

for ((i=0; i==0; ))
do
	# 'rm' 命令的 '-v' 选项也会问这句话.
	echo -n "Are you absolutely sure you want to delete \"$1\" (y/n)? "
	read answer
	case "$answer" in
	[nN]) echo "Changed your mind, huh?"
		  exit $E_CHANGED_MIND ;;
	[yY]) echo; echo "Deleting file \"$1\":"; i=1;;
	   *) ;;
	esac
done

n=`echo $inum | wc -w`
i=0
export i
for ((i=1; i<=n; i++))
do
	inum_next=`echo $inum | awk '{print $ENVIRON["i"]}'`
	find . -inum $inum_next -exec echo {} \;
done

echo

exit 0
