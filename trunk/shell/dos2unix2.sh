
tmpfile="/tmp/sfjsldfjosfjosfjosf232jojf"
swapname="/tmp/dfjjjjjjjjjjjjjjjssss3jfj"

find . -type f | grep -v '.git/' | grep -v '.gitignore' > $tmpfile

cat $tmpfile |
while read line
do
    if [ -z "$line"  ]; then  # 空行
        continue
    fi

    /usr/bin/dos2unix "$line"
done


rm -f $tmpfile
rm -f $swapname

exit 0

