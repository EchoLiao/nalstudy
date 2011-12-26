

## TITLE
1{
# /  <<...>>/
    /^[ \t]*<<\(.*\)>>$/s//#TITLE: \1\n\n#DOC fmt=html: css=moon.css|screen\n#AU: NuoErlz\n#DATE: today\n#MAKETITLE\n#LIST: toc\n/
    t
}

## 页面标题
# /1. aaa/ ; /1.1. / ; /1.1.2. /
/^[0-9][0-9]*[^ ]*\. /{
    h
    # /1. aaa/ ==> /aaa/
    s/^\([0-9][0-9]*[^ ]*\.\) \(.*$\)/\2/
    x
    # /1. aaa/ ==> /1./
    s/^\([0-9][0-9]*[^ ]*\.\) \(.*$\)/\1/g
    # /1./ ==> /1*/
    s/\./*/g
    # /1*/ ==> /*/
    s/[0-9]//g
    G
    # /*\naaa/ => /* aaa/
    s/\n/ /g
}

## 小标题
/^[ \t]*[0-9]*) /{
    s// # /
}

## 小标题
/^\([ \t]*\)([0-9]*) /{
    s//\1 # /
}

#
