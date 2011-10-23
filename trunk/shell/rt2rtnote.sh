#!/bin/sh

#===============================
# Modify follow line to fit you!
rt=/home/scr/.rt
rtnt=/home/scr/.rt-notes
fdir="address-book gs life linux system-install-notes win"

tf=/tmp/find.fileex.tmp.132422


[[ $1 == "-h" ]] && {
    echo "Usage:"
    echo "  `basename $0`"
    echo
    echo "Description:"
    echo "  把 $rt/{$fdir}"
    echo "  目录及子目录下的所有 *.txt, README, INSTALL 文件移动到 $rtnt 目录下,"
    echo "  相应的目录结构保持不变, 并在 $rt 中作出相应的软链接."
    echo
    exit 69
}

cd "$rt"
if [[ $? == 0 ]]; then
    #===============================
    # Modify follow line to fit you!
    echo "THE BASE DIRECTORY IS: $rt/{$fdir}"
    find $fdir -type f \
            -iname "*.txt" -o -iname "README" -o -iname "INSTALL" \
            -iname "README.*" -o -iname "INSTALL.*" \
            | grep -v '\.git' | grep -v '\.svn' | grep -v 'minix.*svn'\
            | grep -v '/rfc/' | grep -v 'softEngineering' > $tf
else
    echo "Can't cd to $rt"
    exit 1
fi

cat $tf |
while read line
do
    if [ -z "$line"  ]; then continue; fi
    if [[ "$line" == "." ]]; then continue; fi
    bname=${line##*/}   # bname=`basename "$line"`
    bpath=${line%/*}    # bpath=${line/%\/$bname/}
    #echo $bpath KKKKKKKKKKKKKKKKKK $bname

    if [[ -L "$rt/$line" ]]; then
        if [[ -f "$rtnt/$line" ]]; then continue; else
            echo "THEY ARE NOT EQUAL 1: $rt/$line AND $rtnt/$line" 1>&2; continue;
        fi
    else
        if [[ ! -e "$rtnt/$line" ]]; then :; else # Move it late
            echo "THEY ARE NOT EQUAL 2: $rt/$line AND $rtnt/$line" 1>&2; continue;
        fi
    fi

    # Move the file ...
    [[ ! -e "$rtnt/$bpath" ]] && mkdir -p "$rtnt/$bpath"
    echo "mv $rt/$bpath/$bname $rtnt/$bpath/$bname"
    mv "$rt/$bpath/$bname" "$rtnt/$bpath/"
    [[ $? == 0 ]] && {
        ln -s "$rtnt/$bpath/$bname" "$rt/$bpath/$bname"
    }

    #sleep 1
done

exit 0
