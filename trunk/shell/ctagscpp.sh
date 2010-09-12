#!/bin/bash
#对std库生成索引
#ctags -R --kinds-c++=+p --fields=+iaS --extra=+q --language-force=c++ .

ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .

# ctags --c++-kinds=+p --fields=+iaS --extra=+q .
