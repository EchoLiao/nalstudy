let SessionLoad = 1
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
imap <F9> :InsPrevHita
imap <F8> :InsNextHita
imap <M-l> :BuildMenua
imap <M-j> :popup PopUpa
imap <F5> :PreviewClassa
inoremap <silent> <Plug>NERDCommenterInInsert  <BS>:call NERDComment(0, "insert")
cnoremap <C-F4> c
inoremap <C-F4> c
cnoremap <C-Tab> w
inoremap <C-Tab> w
cnoremap <M-Space> :simalt ~
inoremap <M-Space> :simalt ~
cmap <S-Insert> +
imap <S-Insert> 
xnoremap  ggVG
snoremap  gggHG
onoremap  gggHG
nnoremap  gggHG
vnoremap  "+y
nmap <silent>  :exe "C c"
noremap  
nmap <silent>  :exe "C n"
noremap  :close
vnoremap  :update
nnoremap  :update
onoremap  :update
nmap  :pwd
nmap  "+gP
omap  "+gP
nmap o <Plug>ZoomWin
vnoremap  "+x
nmap d :cs find d =expand("<cword>")
nmap i :cs find i ^=expand("<cfile>")$
nmap f :cs find f =expand("<cfile>")
nmap e :cs find e =expand("<cword>")
nmap t :cs find t =expand("<cword>")
nmap c :cs find c =expand("<cword>")
nmap g :cs find g =expand("<cword>")
nmap s :cs find s =expand("<cword>")
map ,mbt <Plug>TMiniBufExplorer
map ,mbu <Plug>UMiniBufExplorer
map ,mbc <Plug>CMiniBufExplorer
map ,mbe <Plug>MiniBufExplorer
nmap <silent> ,c <Plug>MarkClear
vmap <silent> ,r <Plug>MarkRegex
nmap <silent> ,r <Plug>MarkRegex
vmap <silent> ,m <Plug>MarkSet
nmap <silent> ,m <Plug>MarkSet
map ,, <Plug>FindMate
map ,rwp <Plug>RestoreWinPosn
map ,swp <Plug>SaveWinPosn
nmap ,caL <Plug>CalendarH
nmap ,cal <Plug>CalendarV
nmap <silent> ,ucs :call C_RemoveGuiMenus()
nmap <silent> ,lcs :call C_CreateGuiMenus()
nmap <silent> ,bv :VSBufExplorer
nmap <silent> ,bs :HSBufExplorer
nmap <silent> ,be :BufExplorer
nmap ,ihn :IHN
nmap ,is :IHS:A
nmap ,ih :IHS
nmap ,ca <Plug>NERDCommenterAltDelims
vmap ,cA <Plug>NERDCommenterAppend
nmap ,cA <Plug>NERDCommenterAppend
vmap ,c$ <Plug>NERDCommenterToEOL
nmap ,c$ <Plug>NERDCommenterToEOL
vmap ,cu <Plug>NERDCommenterUncomment
nmap ,cu <Plug>NERDCommenterUncomment
vmap ,cn <Plug>NERDCommenterNest
vmap ,cb <Plug>NERDCommenterAlignBoth
nmap ,cb <Plug>NERDCommenterAlignBoth
vmap ,cl <Plug>NERDCommenterAlignLeft
nmap ,cl <Plug>NERDCommenterAlignLeft
vmap ,cy <Plug>NERDCommenterYank
nmap ,cy <Plug>NERDCommenterYank
vmap ,ci <Plug>NERDCommenterInvert
nmap ,ci <Plug>NERDCommenterInvert
vmap ,cs <Plug>NERDCommenterSexy
nmap ,cs <Plug>NERDCommenterSexy
vmap ,cm <Plug>NERDCommenterMinimal
nmap ,cm <Plug>NERDCommenterMinimal
vmap ,c  <Plug>NERDCommenterToggle
nmap ,c  <Plug>NERDCommenterToggle
vmap ,cc <Plug>NERDCommenterComment
nmap ,cc <Plug>NERDCommenterComment
map ,jc :call DatabaseCreate ()
map ,jst :call ShowSetupEvnironmentWindow('tags')
map ,jsc :call ShowSetupEvnironmentWindow('cscope')
map ,ds <Plug>StopDrawIt
map ,di <Plug>StartDrawIt
map <silent> ,q :set noai:set tw=78:set fo+=MmVgq:set ai
map <silent> ,sfo :set fo+=Mm
map <silent> ,lhd oI#ifdef  _NAL_HDEBUG_o#elseo#endif
map <silent> ,hh [[
map <silent> ,g %
map <silent> ,bab i{$a}
map <silent> ,bam i[$a]
map <silent> ,bas i($a)
map <silent> ,eab i{ea}
map <silent> ,eam i[ea]
map <silent> ,eas i(ea)
map <silent> ,dte :r ! dateI(A)oi#71a=0
map <silent> ,v2h :source $VIMRUNTIME/syntax/2html.vim
map <silent> ,tof V:s/\\/\//g
map <silent> ,cos mz:%s//&/gn`z
map <silent> ,col :%s/^//n
map <silent> ,cow :%s/\i\+/&/gn
map <silent> ,coc :%s/./&/gn
map <silent> ,anu :%s/^/\=line(".")." "/g
map <silent> ,dap V:s/ //g*
vmap <silent> ,dep mz:s/		*$//ge:s/  *$//ge`z
nmap <silent> ,dep mz:%s/		*$//ge:%s/  *$//ge`z
omap <silent> ,dep mz:%s/		*$//ge:%s/  *$//ge`z
map <silent> ,dsp mz:g/^$/d`z
map <silent> ,sor :!sort
map <silent> ,sfl :.,/^$/-1!sort
map <silent> ,dfg $bhde
map <silent> ,afg mzA // @@@@@`z
map <silent> ,vne :vnew
map <silent> ,vnw :vsplit
map <silent> ,new :new
map <silent> ,onl :only
map <silent> ,clo :close
map <silent> ,nww :split
noremap <silent> ,sl l
noremap <silent> ,sj j
noremap <silent> ,sk k
noremap <silent> ,sh h
noremap <silent> ,mq =
noremap <silent> ,ml L
noremap <silent> ,mj J
noremap <silent> ,mk K
noremap <silent> ,mh H
noremap <silent> ,mr R
noremap <silent> ,vwd 18<
noremap <silent> ,vwi 18>
noremap <silent> ,wd 7-
noremap <silent> ,wi 7+
map <silent> ,vy mz:r!cat /tmp/pwd2vim.tmp0v$hd`zi@Pjdd`zf@x
map <silent> ,y mz:r!cat /tmp/pwd2vim.tmp0v$hd`zi@Pjdd`zf@x
map <silent> ,pwd :pwd
map <silent> ,s2t :%s/	/    /g
map <silent> ,d2s mz:%s/，/, /ge:%s/。/. /ge:%s/；/; /ge:%s/：/: /ge:%s/��/  /ge:%s/“/"/ge:%s/”/"/ge:%s/？/?/ge:%s/！/!/ge:%s/、/,/ge:%s/）/)/ge:%s/（/(/ge:%s/…/.../ge:%s/＝/=/ge:%s/／/\//ge:%s/＊/\*/ge:%s/—/-/ge:%s/＃/#/ge:%s/１/1/ge:%s/２/2/ge:%s/－/-/ge:%s/―/-/ge:%s/’/'/ge:%s/＞/>/ge:%s/\│/|/ge:%s/–/-/ge:%s///ge:%s/←/<--/ge:%s/．/./ge:%s/～/\~/ge:%s/◆//ge:%s/『/</ge:%s/』/>/ge`z
map <silent> ,sss gg/#!hG0dkddkddpi#
map <silent> ,ssb gg/^$qz"bpjjf"mzggjlv$hy*`zpjqi
map <silent> ,ssa gg/^$qz"apjjf"mzggjlv$hy*`zpjqi
map <silent> ,snew ,new:cd /usr/share/tomcat6/webapps/ROOT/sy
map <silent> ,sfj mzgg0W :call Firefox_jsp()`z
map <silent> ,sps gg0:!mkdir gg0vf.h:w .jsp,cccjfGcwutf-8:cd ..:pwd
map <silent> ,b23 mz:%s/utf-8/GB2312/gi`z
map <silent> ,utf mz:%s/GB2312/UTF-8/gi`z
map <silent> ,afl mzlbce<>P`z
vmap <silent> ,dat `>a`<i!!datekJJ
map <silent> ,abk :call AddBkFileLists():!echo z >> /home/scr/bin/bk/app_new_filelists.txt 
nmap ,cw :cw 10 :cn
nmap ,cp :cp
nmap ,cn <Plug>NERDCommenterNest
map <silent> ,s [c
map <silent> ,w ]c
map <silent> ,nsc :set noscrollbind
map <silent> ,sc :set scrollbind
map <silent> ,bgs :TxtBrowserSearch
map <silent> ,bgw :TxtBrowserWord
map <silent> ,bgu :TxtBrowserUrl
map <silent> ,bft :set ft=txt
map <silent> ,jlc :cs show
map <silent> ,jlt :set tags
map <silent> ,cah :CalendarH
map <silent> ,stc :call ToggleSketch()
map <silent> ,ct $F l,c$k$2F l
vnoremap <silent> ,scs :s/ //g
map <silent> ,ccs mz:.,.s/ //g/<Up><Up>`z
map <silent> ,cca ,cak
map <silent> ,cO O0i,ccc
map <silent> ,coo o0i,ccc
map <silent> ,ccc ,cck
nmap <silent> ,tto :NERDTreeToggle
nmap <silent> ,P <Plug>ToggleProject
nmap <silent> ,pr :Project Project zR
nmap <silent> ,ezo :exe "Cfoldvar " . line(".")
map <silent> ,   q:
map <silent> ,eex :C target exec
map <silent> ,efi :C file
map <silent> ,ede :C delete
map <silent> ,eru :exe "C run"
map <silent> ,efn :exe "C finish"
map <silent> ,eib :exe "C info breakpoints"
map <silent> ,efl :C file Example.exe 
map <silent> ,exl :C target exec Example.exe
nmap <silent> ,ihv :IHV
nmap <silent> ,ihs :IHS
nmap <silent> ,ihh :IH
nmap <silent> ,dox :Doxmzkddk2lvf/r=xf Dr*0%hmxl%lr*hj`xjr `xjllvf/hr=f Dhr*`za:	
nmap <silent> ,wm :WMToggle
nmap <silent> ,bot :BottomExplorerWindow
nmap <silent> ,fir :FirstExplorerWindow
map <silent> ,hb :HSBufExplorer
vmap <silent> ,tf "zy:call TlistToggle_close_diCtTmp("__Tag_List__", 2)jh
nmap <silent> ,tf :call TlistToggle_close_diCtTmp("__Tag_List__", 1)jh
omap <silent> ,tf :call TlistToggle_close_diCtTmp("__Tag_List__", 1)jh
map <silent> ,tl :call TlistToggle_close_diCtTmp("diCtTmp", 0)
map <silent> ,cre :cs reset
noremap <silent> ,dva 15+
map <silent> ,viw :call SwitchToBuf("F:/notes/blog/z_other/01OneThousandWrods.txt")
map <silent> ,vig :call SwitchToBuf("F:/notes/blog/vim/regular-expression/regular_expressions_test.txt")
map <silent> ,vif :call SwitchToBuf("C:/Vim/Vim/_vimperatorrc")
map <silent> ,vie :call SwitchToBuf("F:/notes/blog/english/e-new-words.txt")
map <silent> ,vik :call SwitchToBuf("F:/notes/blog/vim/script/vim_script_settings_of_me.txt")
map <silent> ,vib :call SwitchToBuf("F:/notes/blog/book/01.txt")
map <silent> ,vio :call SwitchToBuf("F:/notes/blog/vim/13vim_skill.txt")
map <silent> ,vim :call SwitchToBuf("C:/Vim/Vim/_vimrc")
map <silent> ,vis :source ~\_vimrc
map Q gq
nmap gx <Plug>NetrwBrowseX
map <silent> mm <Plug>Vm_toggle_sign 
vnoremap p :let current_reg = @"gvs=current_reg
map <S-F2> <Plug>Vm_goto_prev_sign
map <F2> <Plug>Vm_goto_next_sign
map <C-F2> <Plug>Vm_toggle_sign
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
nmap <Nul><Nul>d :vert scs find d =expand("<cword>")
nmap <Nul><Nul>i :vert scs find i ^=expand("<cfile>")$	
nmap <Nul><Nul>f :vert scs find f =expand("<cfile>")	
nmap <Nul><Nul>e :vert scs find e =expand("<cword>")
nmap <Nul><Nul>t :vert scs find t =expand("<cword>")
nmap <Nul><Nul>c :vert scs find c =expand("<cword>")
nmap <Nul><Nul>g :vert scs find g =expand("<cword>")
nmap <Nul><Nul>s :vert scs find s =expand("<cword>")
nmap <Nul>d :scs find d =expand("<cword>")	
nmap <Nul>i :scs find i ^=expand("<cfile>")$	
nmap <Nul>f :scs find f =expand("<cfile>")	
nmap <Nul>e :scs find e =expand("<cword>")	
nmap <Nul>t :scs find t =expand("<cword>")	
nmap <Nul>c :scs find c =expand("<cword>")	
nmap <Nul>g :scs find g =expand("<cword>")	
nmap <Nul>s :scs find s =expand("<cword>")	
map <S-F8> :NextInBlock
map <S-F9> :PrevInBlock
nmap <silent> <Plug>RestoreWinPosn :call RestoreWinPosn()
nmap <silent> <Plug>SaveWinPosn :call SaveWinPosn()
nmap <silent> <Plug>CalendarH :cal Calendar(1)
nmap <silent> <Plug>CalendarV :cal Calendar(0)
nmap <silent> <Plug>NERDCommenterAppend :call NERDComment(0, "append")
nnoremap <silent> <Plug>NERDCommenterToEOL :call NERDComment(0, "toEOL")
vnoremap <silent> <Plug>NERDCommenterUncomment :call NERDComment(1, "uncomment")
nnoremap <silent> <Plug>NERDCommenterUncomment :call NERDComment(0, "uncomment")
vnoremap <silent> <Plug>NERDCommenterNest :call NERDComment(1, "nested")
nnoremap <silent> <Plug>NERDCommenterNest :call NERDComment(0, "nested")
vnoremap <silent> <Plug>NERDCommenterAlignBoth :call NERDComment(1, "alignBoth")
nnoremap <silent> <Plug>NERDCommenterAlignBoth :call NERDComment(0, "alignBoth")
vnoremap <silent> <Plug>NERDCommenterAlignLeft :call NERDComment(1, "alignLeft")
nnoremap <silent> <Plug>NERDCommenterAlignLeft :call NERDComment(0, "alignLeft")
vmap <silent> <Plug>NERDCommenterYank :call NERDComment(1, "yank")
nmap <silent> <Plug>NERDCommenterYank :call NERDComment(0, "yank")
vnoremap <silent> <Plug>NERDCommenterInvert :call NERDComment(1, "invert")
nnoremap <silent> <Plug>NERDCommenterInvert :call NERDComment(0, "invert")
vnoremap <silent> <Plug>NERDCommenterSexy :call NERDComment(1, "sexy")
nnoremap <silent> <Plug>NERDCommenterSexy :call NERDComment(0, "sexy")
vnoremap <silent> <Plug>NERDCommenterMinimal :call NERDComment(1, "minimal")
nnoremap <silent> <Plug>NERDCommenterMinimal :call NERDComment(0, "minimal")
vnoremap <silent> <Plug>NERDCommenterToggle :call NERDComment(1, "toggle")
nnoremap <silent> <Plug>NERDCommenterToggle :call NERDComment(0, "toggle")
vnoremap <silent> <Plug>NERDCommenterComment :call NERDComment(1, "norm")
nnoremap <silent> <Plug>NERDCommenterComment :call NERDComment(0, "norm")
map <silent> <Plug>StopDrawIt :set lz:call DrawIt#StopDrawIt():set nolz
map <silent> <Plug>StartDrawIt :set lz:call DrawIt#StartDrawIt():set nolz
onoremap <C-F4> c
nnoremap <C-F4> c
vnoremap <C-F4> c
onoremap <C-Tab> w
nnoremap <C-Tab> w
vnoremap <C-Tab> w
noremap <M-C-X> 
noremap <M-C-A> 
noremap <M-Space> :simalt ~
vmap <S-Insert> 
map <M-n> :tabnext
map <M-p> :tabprevious
map <M-t> :tabnew
map <F3> :tabclose
map <F10> :exe "C p " expand("<cWORD>") 
map <F9> :exe "C p " expand("<cword>") 
map <F8> :exe "Cclear " expand("%") ":" . line(".")
vmap <C-Del> "*d
vnoremap <S-Del> "+x
vnoremap <C-Insert> "+y
nmap <S-Insert> "+gP
omap <S-Insert> "+gP
inoremap  gggHG
inoremap  :update
inoremap  u
cmap  +
imap <silent>  <Plug>VimimChinesemode
imap <silent>  <Plug>VimimOnekey
imap ,ihn :IHN
imap ,is :IHS:A
imap ,ih :IHS
imap <silent> ,ccc /* a */hhi
iabbr ch child
iabbr pa parent
iabbr fo follow-fork-mode
abbr ture true
abbr tehn then
abbr flase false
abbr falut fault
abbr fualt fault
abbr fi if
abbr iont into
abbr inot into
abbr mian main
abbr teh the
iabbr fil C:\Program Files\Vim\vimfiles
iabbr vimm C:\Program Files\Vim\vim72
iabbr doc $HOME/.vim/doc
iabbr plu $HOME/.vim/plugin
iabbr /u /usr/local/share/vim/vim72/
iabbr "e """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iabbr "b """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iabbr //e  *************************************************************************/
iabbr //b /*************************************************************************
iabbr pro $(PROGS)
iabbr pr PROGS =
iabbr li $(LINK.c)
iabbr LI $(LINK.c)
iabbr co $(COMPILE.c)
iabbr CO $(COMPILE.c)
iabbr ldl $(LDLIBS)
iabbr LDL $(LDLIBS)
iabbr ldd $(LDDIR)
iabbr LDD $(LDDIR)
iabbr crv createvar
iabbr ad advertisement
let &cpo=s:cpo_save
unlet s:cpo_save
set ambiwidth=double
set autochdir
set autoindent
set backspace=indent,eol,start
set balloonexpr=BalloonDeclaration()
set browsedir=buffer
set cindent
set completeopt=longest
set cscopetag
set cscopetagorder=1
set cscopeverbose
set noequalalways
set fileencodings=utf-8,chinese
set guioptions=egt
set helplang=Ch
set hlsearch
set incsearch
set linespace=2
set matchtime=7
set path=.,,,./**
set ruler
set scrolloff=2
set shiftwidth=4
set showmatch
set smartindent
set softtabstop=4
set statusline=%f%m%r,%Y,%{&fileformat}\ \ \ ASCII=%b,HEX=%B\ \ \ %l,%c%V\ %p%%\ \ \ [%L\ lines]
set tags=./tags,tags,./tags,./../tags,./../../tags,./../../../tags,./**/tags,tags
set title
set updatetime=500
set viminfo='1000,f1,<500,:50,@50
set nowarn
set whichwrap=b,s,<,>,[,]
set window=38
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd E:\oracle-note\sql
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +12 06procedure-trigger\6_01-procedure.sql
badd +22 07system_security\7_06-type.sql
badd +30 cscope.files
badd +0 02database-table
badd +21 06procedure-trigger\6_02-prcedure.sql
badd +71 05PL_SQL\5_31-package.sql
silent! argdel *
edit 06procedure-trigger\6_02-prcedure.sql
set splitbelow splitright
wincmd _ | wincmd |
split
wincmd _ | wincmd |
split
wincmd _ | wincmd |
split
3wincmd k
wincmd w
wincmd w
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 17 + 19) / 39)
exe '2resize ' . ((&lines * 8 + 19) / 39)
exe '3resize ' . ((&lines * 8 + 19) / 39)
exe '4resize ' . ((&lines * 1 + 19) / 39)
argglobal
let s:cpo_save=&cpo
set cpo&vim
imap <buffer> <C-Left> =sqlcomplete#DrillOutOfColumns()
imap <buffer> <C-Right> =sqlcomplete#DrillIntoTable()
vnoremap <buffer> <silent> [" :exec "normal! gv"|call search('\(^\s*\(--\|\/\/\|\*\|\/\*\|\*\/\).*\n\)\(^\s*\(--\|\/\/\|\*\|\/\*\|\*\/\)\)\@!', "W" )
nnoremap <buffer> <silent> [" :call search('\(^\s*\(--\|\/\/\|\*\|\/\*\|\*\/\).*\n\)\(^\s*\(--\|\/\/\|\*\|\/\*\|\*\/\)\)\@!', "W" )
vmap <buffer> <silent> [{ ?\c^\s*\(\(create\)\s\+\(or\s\+replace\s+\)\{,1}\)\{,1}\<\(function\|procedure\|event\|\(existing\|global\s\+temporary\s\+\)\{,1}table\|trigger\|schema\|service\|publication\|database\|datatype\|domain\|index\|subscription\|synchronization\|view\|variable\)\>
nmap <buffer> <silent> [{ :call search('\c^\s*\(\(create\)\s\+\(or\s\+replace\s+\)\{,1}\)\{,1}\<\(function\|procedure\|event\|\(existing\|global\s\+temporary\s\+\)\{,1}table\|trigger\|schema\|service\|publication\|database\|datatype\|domain\|index\|subscription\|synchronization\|view\|variable\)\>', 'bW')
vmap <buffer> <silent> [] :exec "normal! gv"|call search('\c^\s*end\W*$', 'bW' )
vmap <buffer> <silent> [[ :exec "normal! gv"|call search('\c^\s*begin\>', 'bW' )
nmap <buffer> <silent> [] :call search('\c^\s*end\W*$', 'bW' )
nmap <buffer> <silent> [[ :call search('\c^\s*begin\>', 'bW' )
vnoremap <buffer> <silent> ]" :exec "normal! gv"|call search('^\(\s*\(--\|\/\/\|\*\|\/\*\|\*\/\).*\n\)\@<!\(\s*\(--\|\/\/\|\*\|\/\*\|\*\/\)\)', "W" )
nnoremap <buffer> <silent> ]" :call search('^\(\s*\(--\|\/\/\|\*\|\/\*\|\*\/\).*\n\)\@<!\(\s*\(--\|\/\/\|\*\|\/\*\|\*\/\)\)', "W" )
vmap <buffer> <silent> ]} /\c^\s*\(\(create\)\s\+\(or\s\+replace\s+\)\{,1}\)\{,1}\<\(function\|procedure\|event\|\(existing\|global\s\+temporary\s\+\)\{,1}table\|trigger\|schema\|service\|publication\|database\|datatype\|domain\|index\|subscription\|synchronization\|view\|variable\)\>
nmap <buffer> <silent> ]} :call search('\c^\s*\(\(create\)\s\+\(or\s\+replace\s+\)\{,1}\)\{,1}\<\(function\|procedure\|event\|\(existing\|global\s\+temporary\s\+\)\{,1}table\|trigger\|schema\|service\|publication\|database\|datatype\|domain\|index\|subscription\|synchronization\|view\|variable\)\>', 'W')
vmap <buffer> <silent> ][ :exec "normal! gv"|call search('\c^\s*end\W*$', 'W' )
vmap <buffer> <silent> ]] :exec "normal! gv"|call search('\c^\s*begin\>', 'W' )
nmap <buffer> <silent> ][ :call search('\c^\s*end\W*$', 'W' )
nmap <buffer> <silent> ]] :call search('\c^\s*begin\>', 'W' )
imap <buffer> R :call sqlcomplete#Map('resetCache')
imap <buffer> L :call sqlcomplete#Map('column_csv')
imap <buffer> l :call sqlcomplete#Map('column_csv')
imap <buffer> c :call sqlcomplete#Map('column')
imap <buffer> v :call sqlcomplete#Map('view')
imap <buffer> p :call sqlcomplete#Map('procedure')
imap <buffer> t :call sqlcomplete#Map('table')
imap <buffer> s :call sqlcomplete#Map('sqlStatement')
imap <buffer> T :call sqlcomplete#Map('sqlType')
imap <buffer> o :call sqlcomplete#Map('sqlOption')
imap <buffer> f :call sqlcomplete#Map('sqlFunction')
imap <buffer> k :call sqlcomplete#Map('sqlKeyword')
imap <buffer> a :call sqlcomplete#Map('syntax')
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal balloonexpr=
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal cindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal comments=s1:/*,mb:*,ex:*/,:--,://
setlocal commentstring=/*%s*/
setlocal complete=.,w,b,u,t,i
setlocal completefunc=
setlocal nocopyindent
setlocal nocursorcolumn
set cursorline
setlocal cursorline
setlocal define=\\c\\<\\(VARIABLE\\|DECLARE\\|IN\\|OUT\\|INOUT\\)\\>
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal noexpandtab
if &filetype != 'sql'
setlocal filetype=sql
endif
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
set foldmethod=marker
setlocal foldmethod=marker
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=q
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=2
setlocal imsearch=2
setlocal include=
setlocal includeexpr=
setlocal indentexpr=GetSQLIndent()
setlocal indentkeys=!^F,o,O,=~end,=~else,=~elseif,=~elsif,0=~when,0=)
setlocal noinfercase
setlocal iskeyword=@,48-57,_,128-167,224-235
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal nolist
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=sqlcomplete#Complete
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=4
setlocal noshortname
setlocal smartindent
setlocal softtabstop=4
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'sql'
setlocal syntax=sql
endif
setlocal tabstop=8
setlocal tags=
setlocal textwidth=0
setlocal thesaurus=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
let s:l = 21 - ((9 * winheight(0) + 8) / 17)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
21
normal! 0
wincmd w
argglobal
edit 05PL_SQL\5_31-package.sql
let s:cpo_save=&cpo
set cpo&vim
inoremap <buffer> <silent> <M--> =EchoFuncP()
inoremap <buffer> <silent> <M-=> =EchoFuncN()
imap <buffer> <C-Left> =sqlcomplete#DrillOutOfColumns()
imap <buffer> <C-Right> =sqlcomplete#DrillIntoTable()
vnoremap <buffer> <silent> [" :exec "normal! gv"|call search('\(^\s*\(--\|\/\/\|\*\|\/\*\|\*\/\).*\n\)\(^\s*\(--\|\/\/\|\*\|\/\*\|\*\/\)\)\@!', "W" )
nnoremap <buffer> <silent> [" :call search('\(^\s*\(--\|\/\/\|\*\|\/\*\|\*\/\).*\n\)\(^\s*\(--\|\/\/\|\*\|\/\*\|\*\/\)\)\@!', "W" )
vmap <buffer> <silent> [{ ?\c^\s*\(\(create\)\s\+\(or\s\+replace\s+\)\{,1}\)\{,1}\<\(function\|procedure\|event\|\(existing\|global\s\+temporary\s\+\)\{,1}table\|trigger\|schema\|service\|publication\|database\|datatype\|domain\|index\|subscription\|synchronization\|view\|variable\)\>
nmap <buffer> <silent> [{ :call search('\c^\s*\(\(create\)\s\+\(or\s\+replace\s+\)\{,1}\)\{,1}\<\(function\|procedure\|event\|\(existing\|global\s\+temporary\s\+\)\{,1}table\|trigger\|schema\|service\|publication\|database\|datatype\|domain\|index\|subscription\|synchronization\|view\|variable\)\>', 'bW')
vmap <buffer> <silent> [] :exec "normal! gv"|call search('\c^\s*end\W*$', 'bW' )
vmap <buffer> <silent> [[ :exec "normal! gv"|call search('\c^\s*begin\>', 'bW' )
nmap <buffer> <silent> [] :call search('\c^\s*end\W*$', 'bW' )
nmap <buffer> <silent> [[ :call search('\c^\s*begin\>', 'bW' )
vnoremap <buffer> <silent> ]" :exec "normal! gv"|call search('^\(\s*\(--\|\/\/\|\*\|\/\*\|\*\/\).*\n\)\@<!\(\s*\(--\|\/\/\|\*\|\/\*\|\*\/\)\)', "W" )
nnoremap <buffer> <silent> ]" :call search('^\(\s*\(--\|\/\/\|\*\|\/\*\|\*\/\).*\n\)\@<!\(\s*\(--\|\/\/\|\*\|\/\*\|\*\/\)\)', "W" )
vmap <buffer> <silent> ]} /\c^\s*\(\(create\)\s\+\(or\s\+replace\s+\)\{,1}\)\{,1}\<\(function\|procedure\|event\|\(existing\|global\s\+temporary\s\+\)\{,1}table\|trigger\|schema\|service\|publication\|database\|datatype\|domain\|index\|subscription\|synchronization\|view\|variable\)\>
nmap <buffer> <silent> ]} :call search('\c^\s*\(\(create\)\s\+\(or\s\+replace\s+\)\{,1}\)\{,1}\<\(function\|procedure\|event\|\(existing\|global\s\+temporary\s\+\)\{,1}table\|trigger\|schema\|service\|publication\|database\|datatype\|domain\|index\|subscription\|synchronization\|view\|variable\)\>', 'W')
vmap <buffer> <silent> ][ :exec "normal! gv"|call search('\c^\s*end\W*$', 'W' )
vmap <buffer> <silent> ]] :exec "normal! gv"|call search('\c^\s*begin\>', 'W' )
nmap <buffer> <silent> ][ :call search('\c^\s*end\W*$', 'W' )
nmap <buffer> <silent> ]] :call search('\c^\s*begin\>', 'W' )
imap <buffer> R :call sqlcomplete#Map('resetCache')
imap <buffer> L :call sqlcomplete#Map('column_csv')
imap <buffer> l :call sqlcomplete#Map('column_csv')
imap <buffer> c :call sqlcomplete#Map('column')
imap <buffer> v :call sqlcomplete#Map('view')
imap <buffer> p :call sqlcomplete#Map('procedure')
imap <buffer> t :call sqlcomplete#Map('table')
imap <buffer> s :call sqlcomplete#Map('sqlStatement')
imap <buffer> T :call sqlcomplete#Map('sqlType')
imap <buffer> o :call sqlcomplete#Map('sqlOption')
imap <buffer> f :call sqlcomplete#Map('sqlFunction')
imap <buffer> k :call sqlcomplete#Map('sqlKeyword')
imap <buffer> a :call sqlcomplete#Map('syntax')
inoremap <buffer> 	 =CodeComplete()=SwitchRegion()
inoremap <buffer> <silent> ( (=EchoFunc()
inoremap <buffer> <silent> ) :echo)
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal balloonexpr=
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal cindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal comments=s1:/*,mb:*,ex:*/,:--,://
setlocal commentstring=/*%s*/
setlocal complete=.,w,b,u,t,i
setlocal completefunc=
setlocal nocopyindent
setlocal nocursorcolumn
set cursorline
setlocal cursorline
setlocal define=\\c\\<\\(VARIABLE\\|DECLARE\\|IN\\|OUT\\|INOUT\\)\\>
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal noexpandtab
if &filetype != 'sql'
setlocal filetype=sql
endif
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
set foldmethod=marker
setlocal foldmethod=marker
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=q
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=2
setlocal imsearch=2
setlocal include=
setlocal includeexpr=
setlocal indentexpr=GetSQLIndent()
setlocal indentkeys=!^F,o,O,=~end,=~else,=~elseif,=~elsif,0=~when,0=)
setlocal noinfercase
setlocal iskeyword=@,48-57,_,128-167,224-235
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal nolist
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=sqlcomplete#Complete
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=4
setlocal noshortname
setlocal smartindent
setlocal softtabstop=4
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'sql'
setlocal syntax=sql
endif
setlocal tabstop=8
setlocal tags=
setlocal textwidth=0
setlocal thesaurus=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
let s:l = 71 - ((2 * winheight(0) + 4) / 8)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
71
normal! 0
wincmd w
argglobal
edit cscope.files
inoremap <buffer> 	 =CodeComplete()=SwitchRegion()
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal balloonexpr=
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal cindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal comments=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-
setlocal commentstring=/*%s*/
setlocal complete=.,w,b,u,t,i
setlocal completefunc=
setlocal nocopyindent
setlocal nocursorcolumn
set cursorline
setlocal cursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal noexpandtab
if &filetype != ''
setlocal filetype=
endif
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
set foldmethod=marker
setlocal foldmethod=marker
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=tcq
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=2
setlocal imsearch=2
setlocal include=
setlocal includeexpr=
setlocal indentexpr=
setlocal indentkeys=0{,0},:,0#,!^F,o,O,e
setlocal noinfercase
setlocal iskeyword=@,48-57,_,128-167,224-235
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal nolist
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=4
setlocal noshortname
setlocal smartindent
setlocal softtabstop=4
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != ''
setlocal syntax=
endif
setlocal tabstop=8
setlocal tags=
setlocal textwidth=0
setlocal thesaurus=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
let s:l = 1 - ((0 * winheight(0) + 4) / 8)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
wincmd w
argglobal
edit 06procedure-trigger\6_01-procedure.sql
let s:cpo_save=&cpo
set cpo&vim
inoremap <buffer> <silent> <M--> =EchoFuncP()
inoremap <buffer> <silent> <M-=> =EchoFuncN()
imap <buffer> <C-Left> =sqlcomplete#DrillOutOfColumns()
imap <buffer> <C-Right> =sqlcomplete#DrillIntoTable()
vnoremap <buffer> <silent> [" :exec "normal! gv"|call search('\(^\s*\(--\|\/\/\|\*\|\/\*\|\*\/\).*\n\)\(^\s*\(--\|\/\/\|\*\|\/\*\|\*\/\)\)\@!', "W" )
nnoremap <buffer> <silent> [" :call search('\(^\s*\(--\|\/\/\|\*\|\/\*\|\*\/\).*\n\)\(^\s*\(--\|\/\/\|\*\|\/\*\|\*\/\)\)\@!', "W" )
vmap <buffer> <silent> [{ ?\c^\s*\(\(create\)\s\+\(or\s\+replace\s+\)\{,1}\)\{,1}\<\(function\|procedure\|event\|\(existing\|global\s\+temporary\s\+\)\{,1}table\|trigger\|schema\|service\|publication\|database\|datatype\|domain\|index\|subscription\|synchronization\|view\|variable\)\>
nmap <buffer> <silent> [{ :call search('\c^\s*\(\(create\)\s\+\(or\s\+replace\s+\)\{,1}\)\{,1}\<\(function\|procedure\|event\|\(existing\|global\s\+temporary\s\+\)\{,1}table\|trigger\|schema\|service\|publication\|database\|datatype\|domain\|index\|subscription\|synchronization\|view\|variable\)\>', 'bW')
vmap <buffer> <silent> [] :exec "normal! gv"|call search('\c^\s*end\W*$', 'bW' )
vmap <buffer> <silent> [[ :exec "normal! gv"|call search('\c^\s*begin\>', 'bW' )
nmap <buffer> <silent> [] :call search('\c^\s*end\W*$', 'bW' )
nmap <buffer> <silent> [[ :call search('\c^\s*begin\>', 'bW' )
vnoremap <buffer> <silent> ]" :exec "normal! gv"|call search('^\(\s*\(--\|\/\/\|\*\|\/\*\|\*\/\).*\n\)\@<!\(\s*\(--\|\/\/\|\*\|\/\*\|\*\/\)\)', "W" )
nnoremap <buffer> <silent> ]" :call search('^\(\s*\(--\|\/\/\|\*\|\/\*\|\*\/\).*\n\)\@<!\(\s*\(--\|\/\/\|\*\|\/\*\|\*\/\)\)', "W" )
vmap <buffer> <silent> ]} /\c^\s*\(\(create\)\s\+\(or\s\+replace\s+\)\{,1}\)\{,1}\<\(function\|procedure\|event\|\(existing\|global\s\+temporary\s\+\)\{,1}table\|trigger\|schema\|service\|publication\|database\|datatype\|domain\|index\|subscription\|synchronization\|view\|variable\)\>
nmap <buffer> <silent> ]} :call search('\c^\s*\(\(create\)\s\+\(or\s\+replace\s+\)\{,1}\)\{,1}\<\(function\|procedure\|event\|\(existing\|global\s\+temporary\s\+\)\{,1}table\|trigger\|schema\|service\|publication\|database\|datatype\|domain\|index\|subscription\|synchronization\|view\|variable\)\>', 'W')
vmap <buffer> <silent> ][ :exec "normal! gv"|call search('\c^\s*end\W*$', 'W' )
vmap <buffer> <silent> ]] :exec "normal! gv"|call search('\c^\s*begin\>', 'W' )
nmap <buffer> <silent> ][ :call search('\c^\s*end\W*$', 'W' )
nmap <buffer> <silent> ]] :call search('\c^\s*begin\>', 'W' )
imap <buffer> R :call sqlcomplete#Map('resetCache')
imap <buffer> L :call sqlcomplete#Map('column_csv')
imap <buffer> l :call sqlcomplete#Map('column_csv')
imap <buffer> c :call sqlcomplete#Map('column')
imap <buffer> v :call sqlcomplete#Map('view')
imap <buffer> p :call sqlcomplete#Map('procedure')
imap <buffer> t :call sqlcomplete#Map('table')
imap <buffer> s :call sqlcomplete#Map('sqlStatement')
imap <buffer> T :call sqlcomplete#Map('sqlType')
imap <buffer> o :call sqlcomplete#Map('sqlOption')
imap <buffer> f :call sqlcomplete#Map('sqlFunction')
imap <buffer> k :call sqlcomplete#Map('sqlKeyword')
imap <buffer> a :call sqlcomplete#Map('syntax')
inoremap <buffer> 	 =CodeComplete()=SwitchRegion()
inoremap <buffer> <silent> ( (=EchoFunc()
inoremap <buffer> <silent> ) :echo)
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal balloonexpr=
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal cindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal comments=s1:/*,mb:*,ex:*/,:--,://
setlocal commentstring=<!--%s-->
setlocal complete=.,w,b,u,t,i
setlocal completefunc=javacomplete#CompleteParamsInfo
setlocal nocopyindent
setlocal nocursorcolumn
set cursorline
setlocal cursorline
setlocal define=\\c\\<\\(VARIABLE\\|DECLARE\\|IN\\|OUT\\|INOUT\\)\\>
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal noexpandtab
if &filetype != 'sql'
setlocal filetype=sql
endif
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
set foldmethod=marker
setlocal foldmethod=marker
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=q
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=2
setlocal imsearch=2
setlocal include=
setlocal includeexpr=
setlocal indentexpr=GetSQLIndent()
setlocal indentkeys=!^F,o,O,=~end,=~else,=~elseif,=~elsif,0=~when,0=)
setlocal noinfercase
setlocal iskeyword=@,48-57,_,128-167,224-235
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal nolist
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=sqlcomplete#Complete
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=4
setlocal noshortname
setlocal smartindent
setlocal softtabstop=4
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'sql'
setlocal syntax=sql
endif
setlocal tabstop=8
setlocal tags=
setlocal textwidth=0
setlocal thesaurus=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
let s:l = 12 - ((0 * winheight(0) + 0) / 1)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
12
normal! 0
wincmd w
3wincmd w
exe '1resize ' . ((&lines * 17 + 19) / 39)
exe '2resize ' . ((&lines * 8 + 19) / 39)
exe '3resize ' . ((&lines * 8 + 19) / 39)
exe '4resize ' . ((&lines * 1 + 19) / 39)
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . s:sx
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
