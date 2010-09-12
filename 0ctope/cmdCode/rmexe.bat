@echo on
FOR /R . %%i IN (*.exe *.ilk *.idb *.obj *.pch *.pdb *.bsc *.sbr) DO del /q "%%i"

