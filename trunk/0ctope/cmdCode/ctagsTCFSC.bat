@echo off
rem fullname: ctags_test_currentFile_suportForCtags.bat
rem ���ָ�����ļ�<filename>�Ƿ��ѱ�tags��֧��.
rem ����Ϊ: 	ctags -f - --format=2 --excmd=pattern --fields=nks <filename>

set fla_name=
set /p fla_name=
@echo on
ctags -f - --format=2 --excmd=pattern --fields=nks "%fla_name%"

