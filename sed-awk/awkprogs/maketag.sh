
function doit()  # move filenames to lowercase
{
    for file in ./* ; do
        # ${string##substring}	Strip longest match
        #+ of $substring from front of $string
        filename=${file##*/} # 只保留最短的文件名
        echo $filename
        #case "$filename" in
            #*/*) dirname==${file%/*} ;;
            #*) dirname=.;;
        #esac
        #nf=$(echo $filename | tr A-Z a-z)
        #newname="${dirname}/${nf}"
        #if [ "$nf" != "$filename" ]; then
            #mv "$file" "$newname"
            #echo "lowercase: $file --> $newname"
        #else
            #echo "lowercase: $file not changed."
        #fi
    done
}

# main {
doit
# }
