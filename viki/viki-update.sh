#!/bin/sh

# get_title(arg)
get_title()
{
    titleline="`grep '^#TITLE:' $filename`"
    title="${titleline/\\#TITLE:/}"
    title=`echo $title`
    if test "$title" = ""; then
        title="<无标题文档>"
    fi
}

list_item()
{
    get_title
    echo >> $logfile
    echo "    - [[`basename $filename .viki`][$title]]" >> $logfile
}

# main {
logtitle=`date +"%Y 年 %m 月 %d 日 %H 时 %M 分 %S 秒 更新日志"`
logfile=`date +"log_%Y%m%d.viki"`
echo "#TITLE: $logtitle" > $logfile
echo >> $logfile
echo $logtitle >> $logfile

for item in `grep \\.html$ upload.txt`
do
    filename=`basename $item .html`.viki
    list_item
done

touch log.viki
grep -v '#TITLE:' log.viki > log.bak

echo "#TITLE: 更新日志" > log.viki
echo >> log.viki
echo "    * [[`basename $logfile .viki`][$logtitle]]" >> log.viki
cat log.bak >> log.viki
rm -f log.bak

viki_make.sh
make

exit 0
# }
