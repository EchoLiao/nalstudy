" @_@ List(:h 41.8)||add|+|extend|for|range()|getline()|=~|matchstr
" @_@ Dictionary(:h 41.8)||keys()|sort()|join()|map()|split()|get()|v:val|v:key|copy()|$LANG

""""""""""" List """"""""""""
"# add
:let alist = []
:call add(alist, 'foo')
:call add(alist, 'bar')
:echo alist

"# +
:echo alist + ['foo', 'bar']

"# extend
:let alist = ['one']
:call extend(alist, ['two', 'three'])
:echo alist

"# add
:let alist = ['one']
" 注意, 与extend效果不同!
:call add(alist, ['two', 'three'])
:echo alist

"# for
:let alist = ['one', 'two', 'three']
:for n in alist
:  echo n
:endfor

"# range()
:for a in range(3)
:  echo a
:endfor

"# 循环遍历缓冲区的所有行, 并回显那里找到的任何日期.
" getline() 返回缓冲区所有的行
:for line in getline(1, '$')
   " a =~ b 匹配;  a !~ b 不匹配
:  if line =~ "Date: "
     " \zs 表示: 匹配任何位置, 并将匹配起始处置于该处: 下一个字符将是整个匹配
     " 的第一个字符. 如: Date: 2008.03.22 ok
     "                   返回的是: 2008.03.22.ok
:    echo matchstr(line, 'Date: \zs.*')
:  endif
:endfor



""""""""""" Dictionary """"""""""""
"# 介绍
:let uk2nl = {'one': 'een', 'two': 'twee', 'three': 'drie'}
:echo uk2nl['two']

"# 可以得到字典的键列表并在其上循环
:for key in keys(uk2nl)
:  echo key
:endfor

"# 可以对返回列表按照特定顺序(这里是按ASCII)进行排序
:for key in sort(keys(uk2nl))
:  echo key
:endfor
"  NOTE: 若是字典, 你永远不能得到项目定义时的顺序. 为此目的, 只能用列表. 
"+ 列表里的项目被作为有序序列保存. 

"# 引用字典的值的另一种方法
:echo uk2nl.one
" 加在了字典头
:let uk2nl.four = 'vier'
:echo uk2nl

"# 给字典(uk2nl)添加函数(字典的方法)
"  dict : 是一个特定标记. 表示该函数为某个字典使用. "self" 局部变量这
"+ 时可以引用该字典.
"  split() 接受字符串, 把它分成空白分隔的单词, 并返回这些单词组成的列表
"  get() 函数检查某键是否在字典里存在. 如果是, 提取它对应的键. 如果不
"+ 是, 返回缺省值, 此例中缺省值是 '???'. 
"  map() 遍历列表, 用它的第二个参数来进行计算, 过程中 "v:val" 表示每个
"+ 项目的值; "v:key" 表示当前项目的键.
"  join() 函数和 split() 刚好相反: 它合并列表里的单词, 中间放上空格. 
:function! uk2nl.translate(line) dict
:  return join(map(split(a:line), 'get(self, v:val, "???")'))
:endfunction
:echo uk2nl.translate('three two five one')
"  NOTE: 
"       :let alist = map(split(a:line), 'get(self, v:val, "???")')
"  等价于:
"       :let alist = split(a:line)
"       :for idx in range(len(alist))
"       :  let alist[idx] = get(self, alist[idx], "???")
"       :endfor

"# 面向对象编程
" 1. 建立抽象类
:let transdict = {}
:function transdict.translate(line) dict
:  return join(map(split(a:line), 'get(self.words, v:val, "???")'))
:endfunction
" 2. 实例化一个荷兰语的翻译对象
:let uk2nl = copy(transdict)
" 给words赋值
:let uk2nl.words = {'one': 'een', 'two': 'twee', 'three': 'drie'}
":echo uk2nl.translate('three one')
" 3. 德语的翻译器
:let uk2de = copy(transdict)
:let uk2de.words = {'one': 'ein', 'two': 'zwei', 'three': 'drei'}
":echo uk2de.translate('three one')
" 4. 根据系统环境自动选择翻译器
:if $LANG =~ "zh"
:  let trans = uk2de
:else
:  let trans = uk2nl
:endif
":echo trans.translate('one two three')
" 5. 新增一个翻译器, 并覆盖函数
:let uk2uk = copy(transdict)
:function! uk2uk.translate(line)
:  return a:line
:endfunction
":echo uk2uk.translate('three one wladiwostok')
" 6. 根据系统环境自动选择翻译器
:if $LANG =~ "de"
:  let trans = uk2de
:elseif $LANG =~ "nl"
:  let trans = uk2nl
:else
:  let trans = uk2uk
:endif
:echo trans.translate('one two three')
