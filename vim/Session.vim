let SessionLoad = 1
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
imap <F9> :InsPrevHita
imap <F8> :InsNextHita
imap <F5> :PreviewClassa
inoremap <silent> <Plug>NERDCommenterInInsert  <BS>:call NERDComment(0, "insert")
cnoremap <C-F4> c
inoremap <C-F4> c
cnoremap <C-Tab> w
inoremap <C-Tab> w
imap <S-Insert> 
cmap <S-Insert> +
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
map ,a <Plug>TypecorrAdd
vmap <silent> ,dep mz:s/		*$//ge:s/  *$//ge`z
map <silent> ,ct $F l,c$k$2F l
vmap <silent> ,tf "zy:call TlistToggle_close_diCtTmp("__Tag_List__", 2)
map <silent> ,vtc :call SwitchToBuf("$VIM/vimfiles/plugin/typecorr.vim")
nmap <silent> ,dep mz:%s/		*$//ge:%s/  *$//ge`z
omap <silent> ,dep mz:%s/		*$//ge:%s/  *$//ge`z
nmap <silent> ,tf :call TlistToggle_close_diCtTmp("__Tag_List__", 1)
omap <silent> ,tf :call TlistToggle_close_diCtTmp("__Tag_List__", 1)
map <silent> ,lhd oI#ifdef  _NAL_HDEBUG_o#elseo#endif
map <silent> ,cre :cs reset
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
map <silent> ,ldb oI#ifdef  _NAL_DEBUG_o#elseo#endifk
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
map <silent> ,dsp mz:g/^$/d`z
map <silent> ,sor :!sort
map <silent> ,sfl :.,/^$/-1!sort
map <silent> ,dfg $bhde
map <silent> ,fg ,dlpmzA // @@@@@/<Up><Up>`z
map <silent> ,fag ,dlpmzA // @@@@@/<Up><Up>`z
map <silent> ,afg ,dlpmzA // @@@@@/<Up><Up>`z
map <silent> ,dlp mz:.,.s/		*$//ge:.,.s/  *$//ge`z
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
map <silent> ,d2s mz:%s/，/, /ge:%s/。/. /ge:%s/；/; /ge:%s/：/: /ge:%s/　/  /ge:%s/“/"/ge:%s/”/"/ge:%s/？/?/ge:%s/！/!/ge:%s/、/,/ge:%s/）/)/ge:%s/（/(/ge:%s/…/.../ge:%s/＝/=/ge:%s/／/\//ge:%s/＊/\*/ge:%s/—/-/ge:%s/＃/#/ge:%s/１/1/ge:%s/２/2/ge:%s/－/-/ge:%s/―/-/ge:%s/’/'/ge:%s/＞/>/ge:%s/\│/|/ge:%s/–/-/ge:%s///ge:%s/←/<--/ge:%s/．/./ge:%s/～/\~/ge:%s/◆//ge:%s/『/</ge:%s/』/>/ge:%s/•/./ge:%s/﹐/,/ge:%s/‘/'/ge`z
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
nmap ,cn :cn
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
vnoremap <silent> ,scs :s/ //g
map <silent> ,ccs mz:.,.s/ //g/<Up><Up>`z
map <silent> ,cca ,cak
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
map <silent> ,tl :call TlistToggle_close_diCtTmp("diCtTmp", 0)
map <silent> ,csr :cs reset
noremap <silent> ,dva 15+
map <silent> ,vim :call SwitchToBuf("~/.vimrc")
map <silent> ,vis :source ~/.vimrc
map <silent> ,vll :call SwitchToBuf("~/.vim/log.txt")
map <silent> ,vin :call SwitchToBuf("/home/scr/notes/note/")
map <silent> ,vti :call SwitchToBuf("/home/scr/notes/note/network/cmd_network.txt")
map <silent> ,vfi :call SwitchToBuf("/home/scr/notes/note/linux/note/note/02files_introduce.txt")
map <silent> ,vht :call SwitchToBuf("/home/scr/notes/note/bookmark/html.txt")
map <silent> ,vnt :call SwitchToBuf("/home/scr/notes/note/note.txt")
map <silent> ,vlc :call SwitchToBuf("/home/scr/notes/note/linux/note/cmd/cmd.txt")
map <silent> ,vtm :call SwitchToBuf("/tmp/gvim.tmp.txt")
map <silent> ,viw :call SwitchToBuf("/media/F/notes/blog/z_other/01OneThousandWrods.txt")
map <silent> ,vig :call SwitchToBuf("/media/F/notes/blog/vim/regular-expression/regular_expressions_test.txt")
map <silent> ,vir :call SwitchToBuf("/media/F/notes/blog/vim/regular-expression/regular_expressions.txt")
map <silent> ,vif :call SwitchToBuf("~/.vimperatorrc")
map <silent> ,vie :call SwitchToBuf("/media/F/notes/blog/english/e-new-words.txt")
map <silent> ,vit :call SwitchToBuf("/media/F/notes/blog/sys/CentOS/soft/host/08Linux的ftp服务vsftp详细配置.txt")
map <silent> ,vik :call SwitchToBuf("/media/F/notes/blog/vim/script/vim_script_settings_of_me.txt")
map <silent> ,vib :call SwitchToBuf("/media/F/notes/blog/book/01.txt")
map <silent> ,vio :call SwitchToBuf("/media/F/notes/blog/vim/13vim_skill.txt")
map <silent> ,wvim :call SwitchToBuf("/media/C/Vim/Vim/_vimrc")
cnoremap   :simalt ~
inoremap   :simalt ~
imap ê <RightMouse>a
imap ì :BuildMenu<RightMouse>a
map Q gq
nmap gx <Plug>NetrwBrowseX
map <silent> mm <Plug>Vm_toggle_sign 
vnoremap p :let current_reg = @"gvs=current_reg
onoremap <C-F4> c
onoremap <C-Tab> w
vmap <S-Insert> 
nnoremap <C-F4> c
vnoremap <C-F4> c
nnoremap <C-Tab> w
vnoremap <C-Tab> w
nmap <S-Insert> "+gP
omap <S-Insert> "+gP
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
vnoremap <C-Insert> "+y
vnoremap <S-Del> "+x
map <F3> :tabclose
map <F10> :exe "C p " expand("<cWORD>") 
map <F9> :exe "C p " expand("<cword>") 
map <F8> :exe "Cclear " expand("%") ":" . line(".")
inoremap  gggHG
inoremap  :update
inoremap  u
cmap  +
imap <silent>  <Plug>VimimChinesemode
imap <silent>  <Plug>VimimOnekey
imap ,ihn :IHN
imap ,is :IHS:A
imap ,ih :IHS
noremap  
noremap  
noremap   :simalt ~
noremap ë 
noremap ê 
noremap ù 
noremap å 
map î :tabnext
map ð :tabprevious
map ô :tabnew
iabbr jj ll
iabbr advertisement llllllll
iabbr synchronisation synchronization
iabbr wnat want
iabbr otehr other
iabbr teh the
iabbr ch child
iabbr pa parent
iabbr fo follow-fork-mode
abbr ture true
abbr falut fault
abbr fualt fault
abbr mian main
cabbr teh the
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
set cindent
set completeopt=longest
set cscopetag
set cscopetagorder=1
set cscopeverbose
set noequalalways
set expandtab
set fileencodings=utf-8,chinese
set guioptions=aegit
set helplang=cn
set hlsearch
set iminsert=0
set imsearch=0
set incsearch
set linespace=2
set matchtime=7
set mouse=a
set mousemodel=popup
set path=~/.rt/minix/src-new/minix_svn/**,~/.rt/minix/src-new/minix_svn/include/**,.,/usr/include,,,./**
set ruler
set scrolloff=2
set sessionoptions=blank,buffers,folds,help,options,tabpages,winsize,unix,slash
set shiftwidth=4
set showcmd
set showmatch
set smartindent
set softtabstop=4
set statusline=%f%m%r,%Y,%{&fileformat}\ \ \ ASCII=%b,HEX=%B\ \ \ %l,%c%V\ %p%%\ \ \ [%L\ lines]
set tags=~/.rt/minix/src-new/minix_svn/tags,./tags,./TAGS,tags,TAGS,./tags,./../tags,./../../tags,./../../../tags,./**/tags,tags
set termencoding=utf-8
set textwidth=78
set title
set updatetime=500
set viminfo='1000,f1,<500,:50,@50
set nowarn
set whichwrap=b,s,<,>,[,]
set window=47
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +1 ~/.rt/lang/vim/let.txt
badd +1 ~/.rt/lang/vim/README
badd +1 ~/.rt/lang/vim/reg.txt
badd +1 ~/.rt/lang/vim/vim_cmd_fun.txt
badd +285 ~/.vimrc
badd +1 ~/.rt/lang/vim/List-Dictionary.vim
badd +1 ~/.rt/lang/vim/next_study.txt
badd +1 ~/.rt/lang/vim/other.vim
badd +1 ~/.rt/lang/vim/Session.vim
badd +1 ~/.rt/lang/vim/try.vim
badd +16 ~/.rt/lang/vim/workspace.vim
badd +42 ~/.rt/lang/vim/typecorr.vim
badd +1 /usr/local/share/vimsvn/vim/vimfiles/plugin/typecorr.vim
args ~/.rt/lang/vim/let.txt ~/.rt/lang/vim/README ~/.rt/lang/vim/reg.txt ~/.rt/lang/vim/vim_cmd_fun.txt
edit ~/.rt/lang/vim/typecorr.vim
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 14 + 24) / 48)
exe '2resize ' . ((&lines * 31 + 24) / 48)
argglobal
edit /usr/local/share/vimsvn/vim/vimfiles/doc/usr_41.cnx
inoremap <buffer> 	 =CodeComplete()=SwitchRegion()
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal balloonexpr=
setlocal nobinary
setlocal bufhidden=
setlocal nobuflisted
setlocal buftype=help
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
if &filetype != 'help'
setlocal filetype=help
endif
setlocal foldcolumn=0
setlocal nofoldenable
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
setlocal formatoptions=tcroql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=0
setlocal include=
setlocal includeexpr=
setlocal indentexpr=
setlocal indentkeys=0{,0},:,0#,!^F,o,O,e
setlocal noinfercase
setlocal iskeyword=!-~,^*,^|,^\",192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal nolist
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal nomodifiable
setlocal nrformats=octal,hex
set number
setlocal nonumber
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal readonly
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
if &syntax != 'help'
setlocal syntax=help
endif
setlocal tabstop=8
setlocal tags=
setlocal textwidth=78
setlocal thesaurus=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
let s:l = 1791 - ((11 * winheight(0) + 7) / 14)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1791
normal! 01l
wincmd w
argglobal
edit ~/.rt/lang/vim/typecorr.vim
vnoremap <buffer> <silent> [" :exe "normal! gv"|call search('\%(^\s*".*\n\)\%(^\s*"\)\@!', "bW")
nnoremap <buffer> <silent> [" :call search('\%(^\s*".*\n\)\%(^\s*"\)\@!', "bW")
vnoremap <buffer> <silent> [] m':exe "normal! gv"|call search('^\s*endf*\%[unction]\>', "bW")
nnoremap <buffer> <silent> [] m':call search('^\s*endf*\%[unction]\>', "bW")
vnoremap <buffer> <silent> [[ m':exe "normal! gv"|call search('^\s*fu\%[nction]\>', "bW")
nnoremap <buffer> <silent> [[ m':call search('^\s*fu\%[nction]\>', "bW")
vnoremap <buffer> <silent> ]" :exe "normal! gv"|call search('^\(\s*".*\n\)\@<!\(\s*"\)', "W")
nnoremap <buffer> <silent> ]" :call search('^\(\s*".*\n\)\@<!\(\s*"\)', "W")
vnoremap <buffer> <silent> ][ m':exe "normal! gv"|call search('^\s*endf*\%[unction]\>', "W")
nnoremap <buffer> <silent> ][ m':call search('^\s*endf*\%[unction]\>', "W")
vnoremap <buffer> <silent> ]] m':exe "normal! gv"|call search('^\s*fu\%[nction]\>', "W")
nnoremap <buffer> <silent> ]] m':call search('^\s*fu\%[nction]\>', "W")
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
setlocal comments=sO:\"\ -,mO:\"\ \ ,eO:\"\",:\"
setlocal commentstring=\"%s
setlocal complete=.,w,b,u,t,i
setlocal completefunc=javacomplete#CompleteParamsInfo
setlocal nocopyindent
setlocal nocursorcolumn
set cursorline
setlocal cursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'vim'
setlocal filetype=vim
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
setlocal iminsert=0
setlocal imsearch=0
setlocal include=
setlocal includeexpr=
setlocal indentexpr=GetVimIndent()
setlocal indentkeys=0{,0},:,0#,!^F,o,O,e,=end,=else,=cat,=fina,=END,0\\
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
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
if &syntax != 'vim'
setlocal syntax=vim
endif
setlocal tabstop=8
setlocal tags=
setlocal textwidth=78
setlocal thesaurus=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
let s:l = 29 - ((16 * winheight(0) + 15) / 31)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
29
normal! 0
wincmd w
2wincmd w
exe '1resize ' . ((&lines * 14 + 24) / 48)
exe '2resize ' . ((&lines * 31 + 24) / 48)
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
