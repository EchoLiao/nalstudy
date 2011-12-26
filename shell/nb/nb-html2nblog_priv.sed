# sed script for stract head infomation for nanoblogger.

# sed -n -f nb-html2nblog_priv.sed note.html


# 提取标题
/<title>.*<\/title>/ {
    s/<title>/TITLE: /
    s/<\/title>//
    p
}

# 提取作者名
/<meta name="author" content=/ {
    s/<meta name="author" content="/AUTHOR: /
    s/">//
    p
}

