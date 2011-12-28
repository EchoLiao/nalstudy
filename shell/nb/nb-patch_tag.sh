#/bin/sh

# $0 /home/scr/.rt-notes/linux/computor/grath/opengl/note/22-记录.txt /home/scr/.rt/vercol/git/lang/blog/nb/nuoerlz/data/2011-12-25T17_17_05.txt

function Usage()
{
    echo 1>&2
    echo "Usage: `basename $0` srctxtfile nbmetafile" 1>&2
    echo 1>&2
    exit 1;
}

[[ $# != 2 ]] && {
    Usage
}

tmpdbfile="/tmp/viki_db_tag.tmp.2524.tmp.2.tmp"

   nv_nb="/home/scr/bin/nb/nb"
nblogdir="/home/scr/.rt/vercol/git/lang/blog/nb/nuoerlz"

 srcfile="$1"
metafile="`basename $2`"
  srctag=`head -2 $srcfile | tail -1 | sed 's/^[ 	]*Tags://' | sed 's/^[ 	]*//'`
srctagid=""
metaline=""



## 找出 tag 的 id
lastag=${srctag##*,}    # a,b,c ==> c
curtag=${srctag%%,*}    # a,b,c ==> a
restag=${srctag#*,}     # a,b,c ==> b,c
cd $nblogdir
for (( ; 0 == 0; ))
do
    if [[ "$curtag" == "" ]]; then break; fi
    nbtag=`$nv_nb list tag | grep -w $curtag`
    if [[ "$nbtag" != "" ]]; then
        tagid=`echo $nbtag | awk -F, '{ print $1 }' | sed 's/[ 	]*//g'`
        srctagid=$srctagid","$tagid
    fi

    if [[ "$curtag" == "$lastag" ]]; then break; fi

    curtag=${restag%%,*}    # b,c ==> b
    restag=${restag#*,}     # b,c ==> c
done
srctagid=`echo $srctagid | sed 's/^,//'`
metaline="$metafile>$srctagid"



## 把 id 信息写相应的 *.db 文件
lasid=${srctagid##*,}    # 1,2,3 ==> 3
curid=${srctagid%%,*}    # 1,2,3 ==> 1
resid=${srctagid#*,}     # 1,2,3 ==> 2,3
#echo $metaline              >> $nblogdir/data/master.db
for (( ; 0 == 0; ))
do
    if [[ "$curid" == "" ]]; then break; fi

    firstline=`head -1 $nblogdir/data/cat_$curid.db`
    echo $metaline   >> $nblogdir/data/cat_$curid.db
    echo $firstline   > $tmpdbfile
    sed '1d' $nblogdir/data/cat_$curid.db | sort | sort -t\> +0 -1 -u >> $tmpdbfile
    mv -f $tmpdbfile  $nblogdir/data/cat_$curid.db

    if [[ "$curid" == "$lasid" ]]; then break; fi

    curid=${resid%%,*}    # 2,3 ==> 2
    resid=${resid#*,}     # 2,3 ==> 3
done


exit 0
