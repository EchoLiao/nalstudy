#!/bin/sh

TARGET_DIR=.
TARGET=./public_html
ZIP_FILE=html.zip

curpath=`pwd`
pushd .

cd $TARGET_DIR
rm -f $ZIP_FILE

for file in `cat $curpath/upload.txt`
do
    zip $ZIP_FILE $TARGET/$file
done

popd

rm -f upload.txt
