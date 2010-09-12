

count=0
for filename in *.$1
do
    ((count++))
    echo "$filename --> $count.$1"
    mv "$filename" "$count.$1"
    #mv "$filename" jpg
done

