#!/bin/sh

# 批量自动上传文件脚本

slist=/tmp/tmp_updown_ftp_23433435
stest=tmp/jjj/hhh/kkkk/aaa/bbb/tmp_updown_ftp_23433435
ftpsh1=~/.ftp_updown_tmp_3232222_tmp_1.sh
ftpsh2=~/.ftp_updown_tmp_3232222_tmp_2.sh
npwd=`pwd -P`

do_create_mklist()
{
    tpathres=$1
    tlastname=${1##*/}
    prvpath=.

    cat /dev/null > $2
    for (( ; 0 == 0; ))
    do
        if [[ $tpathres == $tlastname ]]; then break; fi
        st=${tpathres%%/*}
        tpathres=${tpathres#*/}
        prvpath=$prvpath/$st
        #echo $st
        #echo $tpathres
        echo "mkdir $prvpath" >> $2
        #echo 
    done
}


find . -type f | grep -v '.swp' | grep -v '.swo' > $slist

echo "Start ... ..."

cat $slist |
while read line
do

if [ -z "$line"  ]; then continue; fi
sdir=${line%/*}
sfile=${line##*/}
sdir=`echo $sdir | sed 's:^./::'`
line=`echo $line | sed 's:^./::'`
#echo $line
#echo $sdir KKKKKKKKKK
#echo $sfile LLLLLLLLLLLLLLLLLLLLLLLLLLLLLL
#echo

echo ========================================================
echo "ftp -n -i -v 221.1.217.92 << END"    >  $ftpsh1
echo "user nuoerlz xxxxxx"                 >> $ftpsh1
echo "binary"                              >> $ftpsh1
echo "hash"                                >> $ftpsh1
echo "cd /"                                >> $ftpsh1
do_create_mklist $line $ftpsh2               
cat $ftpsh2                                >> $ftpsh1
echo "cd /$sdir"                           >> $ftpsh1
echo "lcd $npwd/$sdir"                     >> $ftpsh1
echo "prompt"                              >> $ftpsh1
echo "mput $sfile"                         >> $ftpsh1
echo "bye"                                 >> $ftpsh1
echo "END"                                 >> $ftpsh1

/bin/sh $ftpsh1

rm -f $ftpsh1


#ftp -n -i -v 221.1.217.92 <<END
#user nuoerlz google
#binary
#hash
#cd /
#mkdir -p /$sdir
#cd /$sdir
#lcd $npwd/$sdir
#prompt
#mput $sfile
#bye
#END

done

echo "Done !!"

exit 0

