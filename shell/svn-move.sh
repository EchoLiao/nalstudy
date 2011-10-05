#!/bin/sh

# modify follow lines fit to you!
#bname=opengl-red
#s_repos=file:///var/svn/books/c-cpp/opengl/openglbk/trunk
#d_base_dir=/media/N/l2this/.rt/lang/books/c/opengl
bname=e4
s_repos=file:///var/svn/lang-me/lang-me/trunk/books/OpenGL/OpenGL-SB/e4
d_base_dir=/media/N/l2this/.rt/lang/books/c/opengl/opengl-blue


s_base_dir=/tmp/svn_move
maxi=1

echo "prepare ... ..."
[ -e $s_base_dir ] && rm -rf $s_base_dir
mkdir -p $s_base_dir

[ ! -e $d_base_dir ] && { 
    echo "Can not find $d_base_dir"
    exit 1
}
mkdir $d_base_dir/$bname
cd $d_base_dir
svn add $bname

svn_checkout_tmp=/tmp/svn_checkout_tmp.13245
svn_out_tmp=/tmp/svn_out_tmp.13245
svn_log_tmp=/tmp/svn_log_tmp.13245
sed_out_tmp=/tmp/sed_out_tmp.13245
sed_log_tmp=/tmp/sed_log_tmp.13245
i=1

echo "checkout ... ..."
cd $s_base_dir
svn checkout $s_repos $bname > $svn_checkout_tmp
maxi=`tail -1 < $svn_checkout_tmp | sed -e 's/^.* //' -e 's/。//'`
cd $s_base_dir/$bname
rm -rf *


echo "move ... ..."
for ((; $i<=$maxi; i++))
do
    echo ================================================================
    cd $s_base_dir/$bname
    svn up -r $i > $svn_out_tmp
    cat $svn_out_tmp
    sed -n -e 's/^[AUG] *//p'  < $svn_out_tmp > $sed_out_tmp
    svn log -r $i > $svn_log_tmp
    sed -e 's/--*//g' -e 's/^r.*$//g' -e '/^$/d' < $svn_log_tmp > $sed_log_tmp

    cd $d_base_dir/$bname
    cat $sed_out_tmp |
    while read line
    do
        if [ -z "$line"  ]; then  # 空行
            continue
        fi
        if [ -d "$s_base_dir/$bname/$line" ]; then
            echo "mkdir... $line "
            mkdir "$d_base_dir/$bname/$line"
        else
            echo "copy...  $line "
            cp -f "$s_base_dir/$bname/$line" "$d_base_dir/$bname/$line"
        fi
        svn add "$line"
    done

    svn commit -F $sed_log_tmp
done

rm -rf $s_base_dir

exit 0
