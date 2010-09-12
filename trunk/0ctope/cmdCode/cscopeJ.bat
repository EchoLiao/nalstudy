cls
@echo on
dir cscope.*
del cscope.*
del ncscope.*
dir cscope.*
call bk.bat
dir /s /b *.java > cscope.files
REM cscope -b -q -k -i cscope.files 
cscope -b
dir cscope.*
