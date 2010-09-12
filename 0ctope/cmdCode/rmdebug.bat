@echo on
REM FOR /D . %%i IN (Debug) DO del /q "%%i"
FOR /d %%i IN (*Debug) DO del %%i
