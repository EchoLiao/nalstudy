@echo off
:a
set /p flag=确定要重启吗(Y/N)? 
if /i "%flag%"=="n" goto b
if  /i "%flag%"=="y" shutdown /t 0 /r  &  exit
rem if  /i "%flag%"=="y" echo lll & pause &  exit
goto a
:b
