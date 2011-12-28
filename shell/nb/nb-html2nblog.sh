#/bin/sh

xte="/usr/bin/xterm -e"
vim="/usr/local/bin/gvim"
 nb="/home/scr/bin/nb/nb"

priv_sed="/home/scr/bin/nb/nb-html2nblog_priv.sed"
sed_tmp="/tmp/nb-html2nblog_priv.sed.tmp.1234592"

outf="`basename $1 .html`.nb.html"


sed -n -f $priv_sed "$1" | sort > $sed_tmp

 title=`tail -1 $sed_tmp`
author=`head -1 $sed_tmp`
  date="DATE: `date \"+%Y-%m-%d %H:%M:%S\"`"
  desc="DESC: "
format="FORMAT: raw"
bodyhr="-----"
bodybe="BODY:"
bodyen="END-----"


echo $title              > $outf
echo $author            >> $outf
echo $date              >> $outf
echo $desc              >> $outf
echo $format            >> $outf
echo $bodyhr            >> $outf
echo $bodybe            >> $outf
cat  $1                 >> $outf
echo $bodyen            >> $outf


#$nb import entry $outf


exit 0
