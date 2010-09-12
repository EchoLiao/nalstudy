@echo off
REM usege: findstr.bat strings file-name
REM     在文件 file-name 中查找字符串, 找出, 则设置环境变量 ERRORLEVEL
REM     为0, 反之设置为1.

findstr /I %1 %2
