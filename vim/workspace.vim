" ^= 表示加到字符前边!
"set path^=/home/scr/.rt/minix/src-new/minix_svn/include/**
"set path^=/home/scr/.rt/minix/src-new/minix_svn/**

"set tags^=/home/scr/.rt/minix/src-new/minix_svn/tags
"cs add /home/scr/.rt/minix/src-new/minix_svn/cscope.out

"不要同时包含 "curdir" 和 "sesdir".
"如果既没有包含 "curdir" 也没有包含 "sesdir", 文件名使用绝对路径保存.
""slash" 和 "unix" 可用于 Windows 系统中, 如果要和 Unix 共享会话文件的
"话. Unix 版本的 Vim 不能执行 dos 格式的脚本, 但是 Windows 版本的 Vim
"可以执行 unix 版本的脚本.
set sessionoptions-=curdir
set sessionoptions-=sesdir
set sessionoptions+=unix
set sessionoptions+=slash
