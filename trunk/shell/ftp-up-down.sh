#!/bin/sh

# 批量自动上传文件脚本

for filename in *
do

ftp -n -i -v 221.1.217.92 <<END
user nuoerlz xxxxxx
binary
hash
cd /
lcd /home/scr/.rt-notes/linux/computor/grath/opengl/note
prompt
mput $filename
bye
END

done

exit 0

