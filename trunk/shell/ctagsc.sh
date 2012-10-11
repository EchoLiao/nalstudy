#!/bin/bash
ctags --version
ctags -R --langmap=c:+.m --c-kinds=+p --fields=+iaS --extra=+q .
# ctags --c-kinds=+p --fields=+iaS --extra=+q .
