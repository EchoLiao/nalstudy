#/bin/sh

# /home/scr/.rt/vercol/git/lang/blog/nb-viki.list


function Usage()
{
    echo 1>&2
    echo "Usage: `basename $0` txtfile" 1>&2
    echo 1>&2
    exit 1;
}


# 对参数进行验证
[[ $# != 1 ]] && {
    Usage
}
filelist="$1"
[[ ! -f "$filelist" ]] && {
    echo "$filelist is NOT a regular file!" 1>&2
    exit 2;
}



nblogdir="/home/scr/.rt/vercol/git/lang/blog/nb/nuoerlz"
 vikidir="/home/scr/.rt/vercol/git/lang/blog/viki/nuoerlz"

TARGET_DIR="TARGET_DIR=$nblogdir/data"
ARGS="ARGS=-m lang-zh_CN-autospace -m utf8 -m code-gvim -t bright.html --css bright -X"
RM="RM=-rm -rf"

sed_pre_txt2viki="sed_pre_txt2viki=/home/scr/.rt/lang/viki/viki-pre_txt2viki.sed"
sed_____txt2viki="sed_____txt2viki=/home/scr/.rt/lang/viki/viki-txt2viki.sed"
sed_las_txt2viki="sed_las_txt2viki=/home/scr/.rt/lang/viki/viki-las_txt2viki.sed"
  sh_html2nbmeta="sh_html2nbmeta=/home/scr/.rt/lang/shell/nb/nb-html2nbmeta.sh"
    sh_patch_tag="sh_patch_tag=/home/scr/.rt/lang/shell/nb/nb-patch_tag.sh"

viki_txt2txt="viki_txt2txt=viki_txtpre.o.tmp"
viki_txt2viki="viki_txt2viki=viki_txt2viki.o.tmp"
viki_viki2viki="viki_viki2viki=viki_viki2viki.viki"
viki_viki2html="viki_viki2html=viki_viki2html.viki"

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
    echo $ARGS                                      >> $tmpfile_val
    echo $RM                                        >> $tmpfile_val
    echo ""                                         >> $tmpfile_val
    echo $sed_pre_txt2viki                          >> $tmpfile_val
    echo $sed_____txt2viki                          >> $tmpfile_val
    echo $sed_las_txt2viki                          >> $tmpfile_val
    echo $sh_html2nbmeta                            >> $tmpfile_val
    echo $sh_patch_tag                              >> $tmpfile_val
    echo ""                                         >> $tmpfile_val
    echo $viki_txt2txt                              >> $tmpfile_val
    echo $viki_txt2viki                             >> $tmpfile_val
    echo $viki_viki2viki                            >> $tmpfile_val
    echo $viki_viki2html                            >> $tmpfile_val
}

# all:
do_create_all()
{
    echo ""                                                          > $tmpfile_all
    echo "TARGETS= \\"                                               >> $tmpfile_all

    cat $filelist |
    while read line
    do
        if [ -z "$line"  ]; then continue; fi # 空行
        dstfile=`echo "$line" | awk '{ print $2 }'`
        echo -e "\t\$(TARGET_DIR)/$dstfile \\"    >> $tmpfile_all
    done

    echo ""                                                         >> $tmpfile_all
    echo "all: \$(TARGETS)"                                         >> $tmpfile_all
}

# depend list
do_create_dep()
{
    echo ""                                                                                > $tmpfile_dep
    cat $filelist |
    while read line
    do
        if [ -z "$line"  ]; then continue; fi # 空行
        srcfile=`echo "$line" | awk '{ print $1 }'`
        dstfile=`echo "$line" | awk '{ print $2 }'`
        echo ""                                                                           >> $tmpfile_dep
        echo "\$(TARGET_DIR)/$dstfile: $srcfile"                                          >> $tmpfile_dep
        echo -e "\tsed -f \$(sed_pre_txt2viki) \$<               > \$(viki_txt2txt)"      >> $tmpfile_dep
        echo -e "\tsed -f \$(sed_____txt2viki) \$(viki_txt2txt)  > \$(viki_txt2viki)"     >> $tmpfile_dep
        echo -e "\tsed -f \$(sed_las_txt2viki) \$(viki_txt2viki) > \$(viki_viki2viki)"    >> $tmpfile_dep
        echo -e "\tdeplate -o \$(viki_viki2html) \$(ARGS) \$(viki_viki2viki)"             >> $tmpfile_dep
        echo -e "\t\$(sh_html2nbmeta) \$(viki_viki2html)         > \$@"                   >> $tmpfile_dep
        echo -e "\t\$(sh_patch_tag) \$< \$@"                                              >> $tmpfile_dep
        echo -e "\t\$(RM) *_code_* deplateCodeAuto*"                                      >> $tmpfile_dep
        echo -e "\t\$(RM) \$(viki_txt2txt) \$(viki_txt2viki) \$(viki_viki2viki) \$(viki_viki2html)" >> $tmpfile_dep
    done
}

# clean:
do_create_cls()
{
    echo ""                                    > $tmpfile_cls
    echo "clean:"                             >> $tmpfile_cls
    echo -e "\t\$(RM) \$(viki_txt2txt)"       >> $tmpfile_cls
    echo -e "\t\$(RM) \$(viki_txt2viki)"      >> $tmpfile_cls
    echo -e "\t\$(RM) \$(viki_viki2viki)"     >> $tmpfile_cls
    echo -e "\t\$(RM) *.viki"                 >> $tmpfile_cls
}

# clean all
do_create_cla()
{
    echo ""                              > $tmpfile_cla
    echo "cleanall: clean"              >> $tmpfile_cla
    echo -e "\t\$(RM) \$(TARGETS)"      >> $tmpfile_cla
    echo -e "\t\$(RM) Makefile"         >> $tmpfile_cla
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

# }    # End of main()

exit 0
