let str = "ping/ping/asjaofjjfi"
let idx = strridx(str, "\/")
echo idx
let len = strlen(str)
echo len
let par = strpart(str, idx + 1, len - idx - 1)
echo par


let lpar = $VIM
" $VIM --> "/usr/local/share/vim"
let tmp = expand(lpar)
echo tmp
