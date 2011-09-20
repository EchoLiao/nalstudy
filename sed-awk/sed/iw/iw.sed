
# sed -n -f iw.sed iw.out

# 从iw.out文件中提取内容, 要求得到的格式如下:
#
# ID MAC essid level
# 01,F4:EC:38:5A:A6:D8,TP-Link-ipad,46
# 02,B0:48:7A:52:76:64,ceshi3,76
# 03,D8:5D:4C:2D:2A:30,Mercury_54M_mw54R,92
# 04,54:E6:FC:7E:01:7E,TP-WR,72
# 05,E0:05:C5:F6:B7:50,zzb_yixian,76


/^ * Cell [0-9][0-9] - / {
    s/^ * Cell *//
    s/ -/,/
    s/ Address: //
    # 把模式空间的内容保存到保存空间, 保存空间之前的内容会被先清除.
    h
}

/^ * ESSID:/ {
    s///
    s/"//g
    # 把模式空间的内容追加到保存空间.
    H
}

/^ *Quality=/ {
    s///
    s/\/.*$//
    H
    g
    s/\n/,/g
    s/,/ /gp
}
