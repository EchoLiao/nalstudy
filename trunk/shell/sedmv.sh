#!/bin/sh

# /home/scr/.rt/linux/computor/tools/vercol/git/progit.org/books/Pro-Git

# find . -type f -name *[^.].html -exec sedmv.sh {} \;

#echo LLLLLLLLL $1

[[ "$1" != "./sedmv.sed" ]] && {
    echo KKKKKKKKK "$1"
    tf=/tmp/sed.tmp.file.121284
    sed -f ./sedmv.sed -- "$1" > $tf
    mv "$1" "$1".OLD
    cat $tf > "$1"
    rm $tf
}

#echo IIIIIIIIIII $1

exit 0
