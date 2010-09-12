@echo off
rem 为c++文件生成索引

call bk.bat
ctags -R --c-kinds=+p --fields=+iaS --extra=+q .

