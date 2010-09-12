#!/bin/bash
# @_@	自己写的一个用于备份一些重要文件的脚本
# string introduction:
# file:///home/scr/notes/note/abs-guide/HTML/refcards.html#AEN17066

bk_svn_root_dir="/bk/"
add_list_dir="/home/scr/bin/bk/"
add_new_file_lists="$add_list_dir/app_new_filelists.txt"
had_add_files="$bk_svn_root_dir/had_add_files.txt"
had_add_dirs="$bk_svn_root_dir/had_add_dirs.txt"
update_log="$bk_svn_root_dir/update_log.txt"
out_error="$bk_svn_root_dir/out_error.txt"
bk_lists="$bk_svn_root_dir/bk_lists.txt"

err_date=0
up_date=0

do_bakeup_file()
{
fullpath_len=`expr length $1` # 字符串长度
filename=`expr "$1" : '.*\(/.*$\)'`   # /.*$ ==> 文件名
filename_len=`expr length $filename`
path_len=$(($fullpath_len - $filename_len))
path=`expr substr $1 1 $path_len`
bk_path=$bk_svn_root_dir$path
bk_filename=$bk_svn_root_dir$1
if [ ! -e "$bk_path" ]; then #  目录不存在, 则创建目录
    mkdir -p $bk_path
fi
if [ ! -e "$bk_filename" ]; then # 该文件从未备份过?
    cp $1 $bk_filename
    if [ "$?" -eq 0 ]; then
	echo -n "$1 " >> $had_add_files
	echo "$2" >> $had_add_files
    else
	if [ "$err_date" -eq 0 ]; then
	    echo "" >> $out_error
	    date >> $out_error
	    err_date=1
	fi
	echo "ERROR: can not copy $1!" >> $out_error
    fi
else
    file_time=`ls -l --time-style=long-iso $1 | awk '{print $6 " " $7}'`
    bk_file_time=`ls -l --time-style=long-iso $bk_svn_root_dir$1 | awk '{print $6 " " $7}'`
    file_time=`date -d "$file_time" +%s`
    bk_file_time=`date -d "$bk_file_time" +%s`
    if [ $file_time -gt $bk_file_time ]; then # 已改变, 则重新备份
	cp $1 $bk_filename
	if [ "$up_date" -eq 0 ]; then
	    echo "" >> $update_log
	    date >> $update_log
	    up_date=1
	fi
	echo "update file: $1" >> $update_log
    fi
fi
}

do_bakeup()
{
if [ -e "$1" ]; then	# 该文件或目录存在?
    if [ -f "$1" ]; then # 是文件?
	head -n 2 $1 > /tmp/bk_nal_tmp
	tac /tmp/bk_nal_tmp > /tmp/bk_nal_tmp2
	flag_line=`head -n 1 /tmp/bk_nal_tmp2`
	comm_flag=`echo $flag_line | awk '{ print $2 }'`
	comm=
	if [ "$comm_flag" == "@_@" ]; then
	    comm=`echo $flag_line | awk '{ print $3 }'`
	    comm="(^ "$comm" ^)"
	fi
	do_bakeup_file "$1" "$comm"
    fi
else
    if [ "$err_date" -eq 0 ]; then
	echo "" >> $out_error
	date >> $out_error
	err_date=1
    fi
    echo "ERROR: $1 NOT exit!" >> $out_error
fi
}

do_bk()
{
if [ -e "$1" ]; then
    cat $1 |
    while read line
    do
	readline=`echo $line | awk '{ print $1 }'`
	if [ -z "$readline"  ]; then  # 空行
	    continue
	fi
	do_bakeup $readline
    done
fi
}

find_all_bk_files()
{
    cd $bk_svn_root_dir
    # sed: 把每一行的第一个字符(.)删除
    find . | sed -e "s/^.//" > $bk_lists
}



# main() {
cd $bk_svn_root_dir
#insert_date

#find_all_bk_files
#do_bk $bk_lists # 检查之前已经备份过的文件有没有被更新过
do_bk $had_add_files

do_bk $add_new_file_lists

echo "" > $add_new_file_lists
# }

exit 0

#  shell里面如何获取字符串长度?
#    len=`expr length $str`
#  另外expr 还可以对字符串取substr , index等, 可以输入expr --help
#    len=`echo $str|awk '{print length($0)}'`
#    echo ${str} | wc -L
#  如何判断变量是否为空?
#    if [  X$A = X ]
#    if [ -z ${A} ]; then
#    ...
#    fi
