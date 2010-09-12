@echo off
:a
set flag_shut=n
set /p flag_shut=确定要关机吗(Y/N)? 
if /i "%flag_shut%"=="n" goto b
if  /i "%flag_shut%"=="y" shutdown /p & exit
goto a
:b
