
sed -n -f iw.sed iw.out > iw.txt.tmp
tail -1 iw.txt.tmp | awk '{ print $1 }' > weneed.txt
cat iw.txt.tmp >> weneed.txt

rm -f iw.txt.tmp

