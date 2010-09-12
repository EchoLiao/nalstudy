#!/bin/bash

TARGET_DIR=./public_html
ARGS="-m lang-zh_CN-autospace -m utf8 -m code-gvim -t bright.html --css bright -X"
#ARGS="-m lang-zh_CN-autospace -m utf8 -m code-gvim -X"

rm -f Makefile

echo TARGET_DIR = $TARGET_DIR >> Makefile
echo ARGS = $ARGS >> Makefile


# all:
echo "" >> Makefile
echo "all: \\" >> Makefile
for file in *.viki
do
    echo -e "\t\$(TARGET_DIR)/`basename $file .viki`.html \\" >> Makefile
done
echo -e "\tupdate_filelist \\" >> Makefile

# depend list
echo "" >> Makefile
for file in *.viki
do
    echo "" >> Makefile
    output=`basename $file .viki`.html
    echo \$\(TARGET_DIR\)/$output: $file >> Makefile
    echo -e "\tdeplate -o \$(TARGET_DIR)/$output \$(ARGS) $file" >> Makefile
    echo -e "\techo `basename $file .viki`.html >> upload.txt" >> Makefile
    echo -e "\trm -f $TARGET_DIR/*_code_* $TARGET_DIR/deplateCodeAuto*" >> Makefile
done

# update_filelist:
echo "" >> Makefile
echo "update_filelist:" >> Makefile
echo -e "\tmv upload.txt upload.bak" >> Makefile
echo -e "\tsort upload.bak | uniq > upload.txt" >> Makefile
echo -e "\trm -f upload.bak" >> Makefile

# clean:
echo "" >> Makefile
echo "clean:" >> Makefile
for file in *.viki
do
    echo -e "\trm -f \$(TARGET_DIR)/`basename $file .viki`.html" >> Makefile
done

# clean all
echo "" >> Makefile
echo "cleanall:" >> Makefile
    echo -e "\trm -f \$(TARGET_DIR)/*.html" >> Makefile
    echo -e "\trm -f \$(TARGET_DIR)/*.css" >> Makefile
    echo -e "\trm -f log*" >> Makefile
    echo -e "\trm -f upload.txt" >> Makefile
    echo -e "\trm -f Makefile" >> Makefile

# make Makefile
#make "$@"

exit 0
