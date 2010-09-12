" @_@ 一些注意事项(:h 41.10)

"
"# 1. 行结束符取决于所在的系统. Unix 系统使用单个的 <NL> 字符. MS-DOS,
"     Windows, OS/2 系列的系统使用 <CR><LF>. 对于那些使用 <CR> 的映射而言, 这
"     一点很重要.

"# 2. 对于一个带有等号 "=" 的 ":set" 命令, 如下:
    :set cpoptions    =aABceFst
" 紧接着等号之前的空白字符会被忽略. 然而其后的空白字符是不允许的!
"
" 为了在一个选项值内使用空格, 必须像下面例子那样使用反斜杠:
    :set tags=my\ nice\ file
" 如果写成这样
    :set tags=my nice file
" Vim 会给出错误信息, 因为它被解释成:
    :set tags=my
    :set nice
    :set file

"# 3. 恢复一个视窗位置
    map ,p ma"aYHmbgg"aP`bzt`a
      " ma                  在当前位置做标记 a
      "   "aY               将当前行拷贝至寄存器 a
      "      Hmb            移动到窗口的顶行并做标记 b
      "         gg          移动到文件首行
      "           "aP       粘贴拷贝的行到上方
      "              `b     移动到刚才的顶行
      "                zt   使窗口出现的文本恢复旧观
      "                  `a 回到保存的光标位置


"# 4. 封装

为了避免你的函数名同其它的函数名发生冲突，使用这样的方法:
- 在函数名前加上独特的字符串。我通常使用一个缩写。例如，"OW_" 被用在 option
window 函数上。
- 将你的函数定义放在一个文件内。设置一个全局变量用来表示这些函数是否已经被加载
了。当再次 source 这个文件的时候，先将这些函数卸载。
例如: 

    " This is the XXX package

    if exists("XXX_loaded")
      delfun XXX_one
      delfun XXX_two
    endif

    function XXX_one(a)
            ... body of function ...
    endfun

    function XXX_two(b)
            ... body of function ...
    endfun

    let XXX_loaded = 1
