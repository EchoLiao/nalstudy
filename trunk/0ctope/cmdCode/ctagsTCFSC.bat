@echo off
rem fullname: ctags_test_currentFile_suportForCtags.bat
rem 检查指定的文件<filename>是否已被tags所支持.
rem 命令为: 	ctags -f - --format=2 --excmd=pattern --fields=nks <filename>

set fla_name=
set /p fla_name=
@echo on
ctags -f - --format=2 --excmd=pattern --fields=nks "%fla_name%"

