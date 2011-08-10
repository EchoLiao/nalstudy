#!/bin/bash
ctags --version
ctags -R --c-kinds=+p --fields=+iaS --extra=+q .
# ctags --c-kinds=+p --fields=+iaS --extra=+q .
