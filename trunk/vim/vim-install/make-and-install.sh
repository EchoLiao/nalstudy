#!/bin/bash

## vim-7.2.tar.bz2
## vimgdb72-1.14.tar.gz
## Makefile.MY


tar xvjf vim-7.2.tar.bz2
tar xvzf vimgdb72-1.14.tar.gz
#打补丁
patch -d vim72 --backup -p0 < vimgdb/vim72.diff
#修改Makefile
cp Makefile.MY vim72/src
cd vim72/src
make -f Makefile.MY
make install
cd ../..

#安装vimgdb
#cd vimgdb
#tar zxf vimgdb_runtime.tgz –C $VIM/vimfiles/

#生成帮助标签
#:helptags ~/.vim/doc

#最在vimrc中加入:
#	 let g:vimgdb_debug_file = ""
#	 run macros/gdb_mappings.vim
