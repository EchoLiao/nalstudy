#/bin/sh


##########################################################
######=================######
# 一些前提步骤: #
#################
## cd /home/scr/.rt/vercol/git/lang/blog/nb         # 
## echo "y" | nb -b nuoerlz add weblog              # 创建naoblogger
## cd nuoerlz                                       #
## git init
## git add *
## git commit -a -m 'init'
## cp -f /home/scr/.rt/vercol/git/rc-files/rt/home/scr/blog.conf .
## git add *
## git commit -a -m 'modify blog.conf fit to me'
## rm -rf articles/*
## nb delete entry 1
## nb delete tag 1 
## git add *
## git commit -a -m 'delete examples'
## /home/scr/bin/nb/nb-create_tag.sh
## git add *
## git commit -a -m 'add tags'
## find . -type d | grep '\.svn' | xargs rm -rf
## git add *
## git commit -a -m 'delete .svn/'
## cp /home/scr/.deplate/css/bright.css /home/scr/.deplate/css/moon.css styles/
#################
##########################################################


  nv_nb="/home/scr/bin/nb/nb"
nv_make="/home/scr/bin/nbviki-make.sh"
nv_3css="/home/scr/bin/nb/nb-nblog3css.sh"
nv_ftp_make="/home/scr/bin/nbviki-ftpup-make.sh"
nv_ftp_upload="/home/scr/bin/nb/nb-ftp_upload_from_list.sh"

nblogdir="/home/scr/.rt/vercol/git/lang/blog/nb/nuoerlz"
ftpupdir="/home/scr/.rt/vercol/git/lang/blog/nb/ftpup"

nv_list="/home/scr/.rt/vercol/git/lang/blog/nb-viki.list"
 nv_log="$nblogdir/nbviki.log"

workdir=/tmp/nbviki_tmp_workdir
findlis=/tmp/nbviki_find_23432.24t.tmp
 ftplis=/tmp/nbviki_ftp_23432.24t.tmp


######=================######
echo ""                                                             >> $nv_log
echo ""                                                             >> $nv_log
echo ""                                                             >> $nv_log
echo "`date`"                                                       >> $nv_log
echo "============================================================" >> $nv_log


######=================######
# 新建一个临时工作目录
rm -rf $workdir
mkdir -p $workdir
cd $workdir


######=================######
# 根据 $nv_list 创建 Makefile, 然后通过 make 产生 naoblogger 
# 所需要的 meta 文件.
$nv_make $nv_list
cd $workdir
export PATH=/usr/local/bin:$PATH
export DISPLAY=:0.0
/usr/bin/xterm -e make >> $nv_log 2>&1


######=================######
# 检查 naoblogger 的数据目录(data)下是否有新的文件或新的改动, 
# 若有则更新以产生新blog文件.
cd $nblogdir
isClean=`git status data | grep "(working directory clean)"`
[[ ! $isClean ]] && {
    echo "y" | $nv_nb --force update all >> $nv_log 2>&1

    # 由于deplate生的html中的css路径在naoblogger下无效, 
    # 所以需要修改一下 css 的路径.
    cd $nblogdir
    find archives/2011/ archives/2012/ articles/ *.html -type f -name '*.html' > $findlis
    cat $findlis |
    while read line
    do
        if [ -z "$line"  ]; then continue; fi # 空行
        $nv_3css "$line" >> $nv_log 2>&1
    done
}


######=================######
# 更新到git库
cd $nblogdir
git add *
git commit -a -m 'save'


######=================######
# 更新到远程服务器
cd $ftpupdir
$nv_ftp_make $ftplis    # 生成 Makefile
cd $ftpupdir
make                    # Just Do It! 把要更新到服务器的文件列表写入 $ftplis
cd $ftpupdir
$nv_ftp_upload $ftplis  # 执行ftp命令更新上传


######=================######
rm -rf $workdir
rm -rf $findlis
rm -rf $ftplis


exit 0
