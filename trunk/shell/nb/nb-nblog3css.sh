#/bin/sh


# 把输入的html文件的css设置路径修改为naoblogger的stytle目录下.


cpwd=`pwd -P`
tfile1="/tmp/nb_sed_cgfile_url_file_1"

# get the files want to sed
cgfile1="$1"

# 找出*.css文件放置的路径
base_url1=`sed -n -e '/nb_default.css/p' $cgfile1 | sed -e 's/^.*href="//' -e 's/\/nb_default.css".*$//'`

# 把 moon.css 和 bright.css 设置为正确的路径
sed -e '/href="moon.css"/s::href="'$base_url1'/moon.css":' \
    -e '/href="bright.css"/s::href="'$base_url1'/bright.css":' \
    $cgfile1 > $tfile1

# ...
mv -f $tfile1 $cpwd/$cgfile1

# clean
rm -f $tfile1

exit 0
