#!/bin/bash

E_BADARGS=65
#DEFAULT_DICTFILE="/usr/share/dict/webster1913-dict.txt"
DEFAULT_DICTFILE="/usr/share/dict/linux.words"

if [[ ("$1" == "-h") || ("$1" == "--help") || ("$1" == "") ]]
then
  echo "Usage: `basename $0` Word_to_define [dictionary]"
  echo
  exit $E_BADARGS
fi

if [ -z "$2" ]
then
  dictfile=$DEFAULT_DICTFILE
else
  dictfile="$2"
fi

Definition=$(sdcv -n "$1")

out1=`echo "$Definition" |
sed -e 's:对不起，没有发现和 :ZZZZZZZZZZ:' \
    -e 's:^$::' \
    -e 's:^\*\[: \[:' \
    -e 's:^\[: &:' \
    -e 's:^a\.: &:' \
    -e 's:^v\.: &:' \
    -e 's:^vi\.: &:' \
    -e 's:^vt\.: &:' \
    -e 's:^n\.: &:' \
    -e 's:^conj\.: &:' \
    -e 's:^interj\.: &:' \
    -e 's:^prep\.: &:' \
    -e 's:^aux\.: &:' \
    -e 's:^art\.: &:' \
    -e 's:^[^a-zA-Z]: &:' \
    -e 's:^  \( [a-zA-Z][a-zA-Z]*\)\( [a-zA-Z][a-zA-Z]*\)*:,&:' \
    -e 's:^-->:@@@@@@@&:' \
| tr -d '\n' |
sed -e 's/发现 .* 条记录和 .* 相似。//g' |
sed -e 's/-->WordNet-->.*-->/	/g' |
sed -e 's/-->.*-->//g' |
sed -e 's/^[^a-zA-Z]*//' |
sed -e 's/相关词组:,/相关词组:/'`


echo ====================
case "$out1" in
        ZZZZZZZZZZ*) ;;
                  *) echo $out1;;
esac

exit 0
