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
    echo "  遍历 $rtnt/{$fdir}"
    echo "  目录及子目录下的所有 *.txt, README, INSTALL 文件,"
    echo "  检查 $rt 中对应的目录下是否已经有对应的软链接指向它, 若没有则加上."
    echo
    exit 69
}

cd "$rtnt"
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
    if [ ! -f "$line" ]; then continue; fi
    bname=${line##*/}   # bname=`basename "$line"`
    bpath=${line%/*}    # bpath=${line/%\/$bname/}

    if [[ ! -L "$rt/$bpath/$bname" ]]; then
        if [[ -f "$rtnt/$bpath/$bname" ]]; then :; else  # Add link late
            continue; # the $rtnt/$line NOT exist, so we do nothing!
        fi
    else
        if [[ -f "$rtnt/$bpath/$bname" ]]; then continue; else
            echo "THEY ARE NOT EQUAL: $rt/$line AND $rtnt/$line" 1>&2; continue;
        fi
    fi

    # Add the link ...
    [[ ! -e "$rt/$bpath" ]] && mkdir -p "$rt/$bpath"
    echo "ln -s $rt/$bpath/$bname $rtnt/$bpath/$bname"
    ln -s "$rtnt/$bpath/$bname" "$rt/$bpath/$bname"

    #sleep 1
done

exit 0
