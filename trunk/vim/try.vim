" @_@ try(:h 41.9)||try|catch|finally|tempname()|delete()|exe "!file"


"# 如果该文件不存在的话, ":read" 命令就会失败. 这段代码可以捕捉到该错
"+ 误并向用户 给出一个友好的信息, 而不是一个一般的出错信息. 
"  NOTE: 只对脚本有效!
:try
:   read ~/templates/pascal.tmpl
:catch /E484:/
:   echo "Sorry, the Pascal template file cannot be found."
:endtry

"# 捕获所有的错误
:try
:   read ~/templates/pascal.tmpl
:catch
:   echo "Sorry, the Pascal template file cannot be found."
:endtry

"# 这个例子将自光标处到文件尾的所有行通过过滤器 "filter". 该程序的参数
"  是文件名. 无论在 ":try" 和 ":finally" 之间发生了什么, "call
"  delete(tmp)" 命令始终被执行. 这可以确保你不会留下一个临时文件. 
:let tmp = tempname()
:try
:   exe ".,$write " . tmp
:   exe "!filter " . tmp
:   .,$delete
:   exe "$read " . tmp
:finally
:   call delete(tmp)
:endtry
