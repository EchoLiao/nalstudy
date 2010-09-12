#!/bin/bash

find . -maxdepth 1 -type f -name '*.h' -or -name '*.c' > tags_list.file 

ctags --c++-kinds=+p --fields=+iaS --extra=+q  -L tags_list.file 
