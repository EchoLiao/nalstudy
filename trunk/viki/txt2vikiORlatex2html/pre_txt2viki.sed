#n

## 除支行未的 "//*/" QQQQQ
# s:[ \t][ \t]*\/\/\*\/$::
/[ \t][ \t]*\/\/\*\//{
    s///
    t addbline
}

##
/^(.* CST)$/{
    s///
    t addbline
}
/^#=====*$/{
    s///
    t addbline
}

## 若"*"是行的第一个字符, 则在其之前加一个空格
/^\*/{
    s// &/
    t addbline
}

## 标准化章节标题
# /1 / ==> /1. /
/^\([0-9][0-9]*\) /{
    s//\1. /
    t addbline
}
# /1.1 / ==> /1.1. /
/^\([0-9][0-9]*[^ ]*[0-9]\) /{
    s//\1. /
    t addbline
}

# ## 高亮命令行
:bcmd
/^[ \t]*\(\[.*\][#\$] \)/{
:bhold
    s/^[ \t]*\(\[.*\][#\$] \)/\1/
    /[ \t][ \t]*\/\/\*\//{
        s///
    }
    H
    n
    /^$/{
        g
        # s/\n/&&/
        s/^/#Code syntax=txt <<---/
        s/$/\n---\n/
        b addbline
    }
    //!b bhold
    b bcmd
}

##
/Note:/{
:bnote
    H
    n
    /^$/{
        g
        s/Note:/#Native fmt=html <<---\n<span style="background-color: #ffff00"><font color="#0000ff">\n&<\/font><\/span>/
        s/$/\n---\n\n/
        b addbline
    }
    b bnote
}

# Note: svn add 不能add.svn中记录有的目录或文件




##
:addbline
/$/{
    s//\n/p
    # p
}
g
s/.*//g
x
s/.*//g
