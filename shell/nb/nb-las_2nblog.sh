#/bin/sh


# cgfile1: archives/2011/12/23/notes_1/index.html
# cgfile2: archives/2011/12/index.html
# cgfile3: index


cpwd=`pwd -P`
new_html_list="/tmp/nb_new_html_list.tmp.2342l29"
tfile1="/tmp/nb_sed_cgfile_url_file_1"
tfile2="/tmp/nb_sed_cgfile_url_file_2"
tfile3="/tmp/nb_sed_cgfile_url_file_3"

# get new html file list
git status . | grep '.html' | sed -e 's/^#	.*://' -e 's/^ *\([^ ]\)/\1/' | sort > $new_html_list

# get the files want to sed
cgfile1=`cat $new_html_list | sed -n -e '/^archives\/[0-9]*\/[0-9]*\/[0-9]*\/.*\/index\.html$/p'`
cgfile2=`cat $new_html_list | sed -n -e '/^archives\/[0-9]*\/[0-9]*\/index\.html$/p'`
cgfile3=`cat $new_html_list | sed -n -e '/^index\.html$/p'`

# 找出*.css文件放置的路径
base_url1=`sed -n -e '/nb_default.css/p' $cgfile1 | sed -e 's/^.*href="//' -e 's/\/nb_default.css".*$//'`
base_url2=`sed -n -e '/nb_default.css/p' $cgfile2 | sed -e 's/^.*href="//' -e 's/\/nb_default.css".*$//'`
base_url3=`sed -n -e '/nb_default.css/p' $cgfile3 | sed -e 's/^.*href="//' -e 's/\/nb_default.css".*$//'`

# 把 moon.css 和 bright.css 设置为正确的路径
sed -e '/href="moon.css"/s::href="'$base_url1'/moon.css":' \
    -e '/href="bright.css"/s::href="'$base_url1'/bright.css":' \
    $cgfile1 > $tfile1
sed -e '/href="moon.css"/s::href="'$base_url2'/moon.css":' \
    -e '/href="bright.css"/s::href="'$base_url2'/bright.css":' \
    $cgfile2 > $tfile2
sed -e '/href="moon.css"/s::href="'$base_url3'/moon.css":' \
    -e '/href="bright.css"/s::href="'$base_url3'/bright.css":' \
    $cgfile3 > $tfile3

# ...
mv -f $tfile1 $cpwd/$cgfile1
mv -f $tfile2 $cpwd/$cgfile2
mv -f $tfile3 $cpwd/$cgfile3

exit 0
