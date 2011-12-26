#/bin/sh


[[ $# != 1 ]] && {
    echo "Usage: `basename $0` listfile"
    exit 1
}


nblogdir="/home/scr/.rt/vercol/git/lang/blog/nb/nuoerlz"
ftpupdir="/home/scr/.rt/vercol/git/lang/blog/nb/ftpup"
#ftpupload="/home/scr/bin/nb/nb-ftp_updown_onefile.sh"

filelist="/tmp/nb_viki_find_up_ftp.tmp.2342.2.tmp"
 ftplist="$1"


rm -f $ftplist


cd $nblogdir
find archives/ articles/ -type f -name '*.html'              > $filelist
find images/ *.html *.xml styles/ -type f                   >> $filelist


cd $ftpupdir

TARGET_DIR="TARGET_DIR=$ftpupdir"
SOURCE_DIR="SOURCE_DIR=$nblogdir"
RM="RM=-rm -rf"


tmpfile_val="/tmp/tmpfile_val.nbviki.23432.tmp"
tmpfile_all="/tmp/tmpfile_all.nbviki.23432.tmp"
tmpfile_dep="/tmp/tmpfile_dep.nbviki.23432.tmp"
tmpfile_cls="/tmp/tmpfile_cls.nbviki.23432.tmp"
tmpfile_cla="/tmp/tmpfile_cla.nbviki.23432.tmp"


# val
do_create_val()
{
    echo ""                                          > $tmpfile_val
    echo $TARGET_DIR                                >> $tmpfile_val
    echo $SOURCE_DIR                                >> $tmpfile_val
    echo $RM                                        >> $tmpfile_val
}

# all:
do_create_all()
{
    echo ""                                                 > $tmpfile_all
    echo "TARGETS= \\"                                     >> $tmpfile_all

    cat $filelist |
    while read line
    do
        if [ -z "$line"  ]; then continue; fi # 空行
        echo -e "\t\$(TARGET_DIR)/./$line \\"              >> $tmpfile_all
    done

    echo ""                                                >> $tmpfile_all
    echo "all: \$(TARGETS)"                                >> $tmpfile_all
}

# depend list
do_create_dep()
{
    echo ""                                                 > $tmpfile_dep
    cat $filelist |
    while read line
    do
        if [ -z "$line"  ]; then continue; fi # 空行
        line="./"$line
        bname=${line##*/}
        bpath=${line%/*}
        echo ""                                            >> $tmpfile_dep
        echo "\$(TARGET_DIR)/$line: \$(SOURCE_DIR)/$line"  >> $tmpfile_dep
        #echo -e "\t$ftpupload $line"                       >> $tmpfile_dep
        echo -e "\tmkdir -p \$(TARGET_DIR)/$bpath"         >> $tmpfile_dep
        echo -e "\tcp -f \$<  \$@"                         >> $tmpfile_dep
        echo -e "\techo \"$line\" >> $ftplist"             >> $tmpfile_dep
    done
}

# clean:
do_create_cls()
{
    echo ""                                    > $tmpfile_cls
    echo "clean:"                             >> $tmpfile_cls
    echo -e "\t#\$(RM) \$(TARGET_DIR)/*"      >> $tmpfile_cls
}

# clean all
do_create_cla()
{
    echo ""                                > $tmpfile_cla
    echo "cleanall: clean"                >> $tmpfile_cla
    echo -e "\t#\$(RM) \$(TARGET_DIR)/*"  >> $tmpfile_cla
}



# main() {

do_create_val
do_create_all
do_create_dep
do_create_cls
do_create_cla

cat $tmpfile_val     > Makefile
cat $tmpfile_all    >> Makefile
cat $tmpfile_dep    >> Makefile
cat $tmpfile_cls    >> Makefile
cat $tmpfile_cla    >> Makefile

rm -f $tmpfile_val
rm -f $tmpfile_all
rm -f $tmpfile_dep
rm -f $tmpfile_cls
rm -f $tmpfile_cla
rm -f $filelist

# }    # End of main()

exit 0

