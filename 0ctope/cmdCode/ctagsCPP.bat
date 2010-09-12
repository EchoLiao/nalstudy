@echo off
rem 为c++文件生成索引
rem
rem 对std库生成索引
rem ctags -R --kinds-c++=+p --fields=+iaS --extra=+q --language-force=c++ .

call bk.bat
ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .


