#/bin/sh

xte="/usr/bin/xterm -e"
vim="/usr/local/bin/gvim"
 nb="$HOME/bin/nb/nb"

outf="$1.nb.html"

title=`head -1 "$1" | sed -e 's/^[ 	]*<<//' -e 's/>>[ 	]*$//'`
 tags=`head -2 "$1" | tail -1 | sed -e 's/^[ 	]*Tags: //' -e 's/[ 	]*$//'`

 title="TITLE: $title"
author="AUTHOR: NuoErlz"
  date="DATE: `date \"+%Y-%m-%d %H:%M:%S\"`"
  desc="DESC: "
format="FORMAT: raw"
bodyhr="-----"
bodybe="BODY:"
bodyen="END-----"


$xte $vim -c 'set nonu' -c 'source $VIMRUNTIME/syntax/2html.vim' \
     -c 'w!' -c 'qa!' "$1" > /dev/null 2>&1

echo $title              > $outf
echo $author            >> $outf
echo $date              >> $outf
echo $desc              >> $outf
echo $format            >> $outf
echo $bodyhr            >> $outf
echo $bodybe            >> $outf
cat  $1.html            >> $outf
echo $bodyen            >> $outf

$nb import entry $outf


#echo $title
#echo $tags

