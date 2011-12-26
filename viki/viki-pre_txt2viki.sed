#n

## 删除行未的 "//*/" QQQQQ
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

# ## 高亮代码行
:bcode
/^[ \t]*\/\/[ \t]*#.*---/{
:bholdcode
    s:^[ \t]*//[ \t]*#\(.*\)---:@!!@\1@!!@:
    H
    n
    /^[ \t]*\/\/[ \t]*#.*---end/{
        g
        s/@!!@\(.*\)@!!@/#Code syntax=\1 <<---/
        s/$/\n---\n/
        b addbline
    }
    //!b bholdcode
    b bcode
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
    # 加入空行的目的是为了保持原文的排版, 否则viki会
    # 自动把连续的非空行连接为一行!
    ## s//\n/p

    # 让viki自动把连续的非空行连接为一行!
    p
}
g
s/.*//g
x
s/.*//g
