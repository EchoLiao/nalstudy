@echo off
:a
set /p flag=ȷ��Ҫ������(Y/N)? 
if /i "%flag%"=="n" goto b
if  /i "%flag%"=="y" shutdown /t 0 /r  &  exit
rem if  /i "%flag%"=="y" echo lll & pause &  exit
goto a
:b
