# .bashrc

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

## 对所有用户都有效的环境变量保存在 /etc/profile 中.
export PATH=$HOME/bin:$PATH:/usr/bin:/sbin
export SVN_EDITOR=vim #set for svn
## fcitx环境变量
export XMODIFIERS="@im=fcitx"
export GTK_IM_MODULE=xim
## 命令提示符
#export PS1='[\!\#\u\$\\\d\h\n\nnn\s\t\W\w]$'
if [ `whoami` == "root" ]; then
    export PS1='\[\033[31m\][\u \W]# \[\033[m\]'
else
    export PS1='\[\033[31m\][\u \W]$ \[\033[m\]'
fi
## history
# see: bash_history.txt
export HISTSIZE=100000
export HISTTIMEFORMAT='%F %T ' #命令历史前显示时间
export HISTFILE=/home/scr/.bash_history #设置历史命令存储的文件
export HISTIGNORE='pwd:ls:lx:ls -ltr:ll:la:du:ds:df:h:..:l:j:sl:ip a:' #使用 HISTIGNORE 忽略历史中的特定命令
shopt -s histappend # 使用追加而不是覆盖的方式将命令写入文件
PROMPT_COMMAND="history -a; $PROMPT_COMMAND" # bash每执行完一条命令, 都把其保存到命令历史里
### see also ~/.inputrc
### 作用:
# 当命令行上没有输入时, 上下方向键的作用和以前一样, 但是当输入了内容, 如ssh -l,
# 之后, bash只会列出以该字符串开头的命令, 这样极大地缩小了搜索范围, 非常高效.
export HISTCONTROL=ignoredups #从命令历史中剔除连续重复的条目
#export HISTCONTROL=erasedups #清除整个命令历史中的重复条目 # 该选项要放在最后边才可以生效
#export HISTCONTROL=ignorespace # 注意, 命令以空格开头, 历史记录中就不会记录这条命令

## grep
# NOTE: 一定不要设置下面的选项!!! 因为会影响grep的输出!
# export GREP_OPTIONS='--color=always'
export GREP_COLOR='1;32'



alias ..='cd ..'
alias ...='cd ../../'
alias cdab='cd /media/E/lang/sap/0abap/all'
alias cdav='cd /home/scr/.aMule/Incoming'
alias cdb='cd /home/scr/bin'
alias cdbo='cd /home/scr/.rt/book/'
alias cdbot='cd /home/scr/.rt/book/tools/'
alias cdbotvm='cd /home/scr/.rt/book/tools/vm'
alias cdbotvmn='cd /home/scr/.rt/book/tools/vm/note/'
alias cdbs='cd /home/scr/.rt/lang/shell/stsc'
alias cd..='cd ..'
alias cdif='cd /etc/sysconfig/network-scripts/'
alias cdjs='cd /usr/share/tomcat6/webapps/ROOT/sy/'
alias cdlc='cd /home/scr/.rt/lang/c-cpp/c'
alias cdl='cd /home/scr/.rt/lang/'
alias cdlk='cd /home/scr/.rt/lang/linux-src/kernel/'
alias cdlcm='cd /home/scr/.rt/lang/c-cpp/c/minix/'
alias cdlcn='cd /home/scr/.rt/notes/note/linux/note/cmd'
alias cdlnc='cd /home/scr/.rt/notes/note/linux/note/cmd'
alias cdln='cd /home/scr/.rt/notes/note/linux/note/note'
alias cdlv='cd /home/scr/.rt/lang/vim'
alias cdm='cd /media'
alias cdme='cd /media/E'
alias cdmf='cd /media/F'
alias cdmib='cd /home/scr/.rt/minix/note/book/'
alias cdmi='cd /home/scr/.rt/minix/'
alias cdmin='cd /home/scr/.rt/minix/note/'
alias cdmis='cd /home/scr/.rt/minix/src-new/minix_svn/'
alias cdn='cd /home/scr/.rt/notes/note'
alias cdnvim='cd /home/scr/.rt/notes/note/vim'
alias cdrk='cd /home/scr/.rt/book/html/man.lupaworld.com/content/manage/ringkee'
alias cdrt='cd /home/scr/.rt/'
alias cds='cd /home/scr/.rt/notes/soft'
alias cdse='cd ~/bin/stsc'
alias cdsvnn='cd /home/scr/.rt/book/tools/svn/note'
alias cdtin='cd /home/scr/.rt/book/TCP-IP_I1/note/'
alias cdtis='cd /home/scr/.rt/book/TCP-IP_I1/src/'
alias chmodd='find . -type d | xargs chmod 755'
alias chmodf='find . -type f | xargs chmod 644'
alias cdtrash='cd /home/scr/.local/share/Trash/files'
alias cdun='cd /home/scr/.rt/book/TCP-IP/unpv1/unpv13e/src/unpv13e'
alias cdv='cd /usr/local/share/vim'
alias cdvf='cd /usr/local/share/vim/vimfiles/'
alias cdvmn='cd /home/scr/.rt/book/tools/vm/note/'
alias cdvp='cd /usr/local/share/vim/vimfiles/plugin/'
alias cdvt='cd /media/F/notes/blog/vim/01tutorial'
alias cdx='cd /home/scr/xiazai'
alias chklg='chkconfig --list | grep --color=always'
alias chm='gnochm'
alias chms='gnochm /media/E/liaocaiyuan/Documents/0电子书/0现修课程/第3学期/操作系统设计与实现/aybook第三版\(英文\).chm&'
alias chx='chmod +x'
alias cmd='gnome-terminal --geometry=100x38'
alias df='date >> /tmp/df.tmp.log; df -h >> /tmp/df.tmp.log;echo >> /tmp/df.tmp.log; df  -h'
alias ds='du -hs'
alias du='du -h'
alias e='e.sh'
alias ex='nautilus'
alias exv='nautilus trash:'
alias fd='fdisk -l'
alias ffbs='firefox /home/scr/.rt/notes/note/linux/note/cmd/shell/abs-guide/HTML/index.html'
alias ff='firefox'
alias fflatex='firefox /home/scr/.rt/book/tools/latex/edt1023.sayya.org/tex/latex123/index.html'
alias ffsvn='firefox /home/scr/.rt/notes/note/develop/svn/svn-book-html/svn-book.html'
alias fg.='find . | grep --color=always'
alias fgf='find . -type f | grep --color=always'
alias fgd='find . -type d | grep --color=always'
alias fgx='find . -type f | xargs grep --color=always'
alias fiq='find . -type f | xargs grep --color=always '?????''
alias fl='fdisk -l'
alias g='gvim'
alias gvbkf='gvim /home/scr/bin/bk/app_new_filelists.txt'
alias gvbs='gvim ~/.bashrc'
alias gvfi='gvim /home/scr/.rt/notes/note/linux/note/note/02files_introduce.txt'
alias gvfl='gvim /home/scr/.rt/notes/soft/yum/fedora_log.txt'
alias gvhi='gvim ~/.bash_history'
alias gvht='gvim /home/scr/.rt/notes/note/bookmark/html.txt'
alias gvip='gvim /etc/sysconfig/network-scripts/ifcfg-eth0'
alias gvlc='gvim /home/scr/.rt/notes/note/linux/note/cmd/cmd.txt'
alias gvnc='gvim /home/scr/.rt/notes/note/network/cmd_network.txt'
alias gvnd='gvim /home/scr/.rt/notes/note'
alias gvnt='gvim /home/scr/.rt/notes/note/note.txt'
alias gvsp='gvim /home/scr/.rt/notes/note/study_process.txt'
alias gvvl='gvim /home/scr/.rt/notes/note/vim/log.txt'
alias h='history | tac | less'
alias ifse='ifconfig eth0; ifconfig eth0:0'
alias ifs='ifconfig'
alias jj='ll'
alias j='jobs'
alias kk='ll'
alias la='ls -a'
alias lc='ls -lcr'		# sort by change time
alias lla='ll -a'
alias ll.='l. -l'
alias llr='ll -R'
alias lls='ll -Sr'
alias llsr='ll -S'
alias llx='ll -X'
alias llxr='ll -Xr'
alias lm='ll | less'
alias lr='ls -R'
alias ls='ls -h --color'
alias lt='ls -ltr'              # sort by date
alias lu='ls -lur'		# sort by access time
alias lx='ls -X'
alias mac2='ifconfig eth0 down; ifconfig eth0 hw ether 00:1E:90:13:e0:26; ifconfig eth0 up'
alias mac='sudo ifconfig eth0 down; ifconfig eth0 hw ether 00:1E:90:13:e0:25; ifconfig eth0 up; sudo service network restart; mentohust'
alias ma='make'
alias mca='make cleanall'
alias mc='make clean'
alias m='man'
alias moc='mount /dev/sda1 /media/C'
alias mod='mount /dev/sda3 /media/D'
alias moe='mount /dev/sda5 /media/E'
alias mof='mount /dev/sda6 /media/F'
alias ms='cd /home/scr/bin/stsc/'
alias p6='ping6'
alias path='echo -e ${PATH//:/\\n}'
alias pdf='okular --icon okular -caption Okular'
alias pdfs='okular --icon okular -caption Okular /media/E/liaocaiyuan/Documents/0电子书/0现修课程/第3学期/操作系统设计与实现/2上册\(解密\).pdf&'
alias pg='ps aux | grep --color=always'
alias pkau='pkill pulseaudio*'
alias pl='pdflatex'
alias po='popd'
alias p='ping'
alias pu='pushd'
alias r6='route -A inet6'
alias rasun='route add -net 172.18.13.0/24 gw sun'
alias rn6='route -n -A inet6'
alias rn='route -n'
alias r='route'
alias sl='ls'
alias s='sdcv'
alias .s='source ~/.bashrc'
alias tma='tomcat6 start'
alias tmo='tomcat6 stop'
alias tree='tree -Csu'		# nice alternative to 'ls'
alias t='top'
alias umoc='umount /dev/sda1'
alias umod='umount /dev/sda3'
alias umoe='umount /dev/sda5'
alias umof='umount /dev/sda6'
alias vbkf='vim /home/scr/.rt/bin/bk/app_new_filelists.txt'
alias vbs='vim   /home/scr/.bashrc'
alias vfi='vim /home/scr/.rt/notes/note/linux/note/note/02files_introduce.txt'
alias vfl='vim /home/scr/.rt/notes/soft/yum/fedora_log.txt'
alias vhi='vim ~/.bash_history'
alias vhosts='vim /etc/hosts'
alias vht='vim /home/scr/.rt/notes/note/bookmark/html.txt'
alias vife00='vim /etc/sysconfig/network-scripts/ifcfg-eth0:0'
alias vife0='vim /etc/sysconfig/network-scripts/ifcfg-eth0'
alias vife1='vim /etc/sysconfig/network-scripts/ifcfg-eth1'
alias vlc='vim /home/scr/.rt/notes/note/linux/note/cmd/cmd.txt'
alias vnt='vim /home/scr/.rt/notes/note/note.txt'
alias vrc='vim /etc/rc.d/rc.local'
alias vvl='vim ~/.vim/log.txt'
alias wh='type -all'
alias ,y='p2v.sh'


hg(){ history | grep $* | sort -k 2 | uniq -s 7 | sort -g | less; } #过虑命令历史

# Find a file with a pattern in name:
function fif() { find . -type f -iname '*'$*'*' -ls  | column -t; }
# Find a file with pattern $1 in name and Execute $2 on it:
function fie() { find . -type f -iname '*'$1'*' -exec "${2:-file}" {} \;  ; }
function fstr()
{
    OPTIND=1
    local case=""
    local usage="fstr: find string in files.
Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "
    while getopts :it opt
    do
        case "$opt" in
        i) case="-i " ;;
        *) echo "$usage"; return;;
        esac
    done
    shift $(( $OPTIND - 1 ))
    if [ "$#" -lt 1 ]; then
        echo "$usage"
        return;
    fi
    local SMSO=$(tput smso)
    local RMSO=$(tput rmso)
    find . -type f -name "${2:-*}" -print0 | xargs -0 grep -sn ${case} "$1" 2>&- | \
sed "s/$1/${SMSO}\0${RMSO}/gI" | less
}

function cuttail() # cut last n lines in file, 10 by default # QQQQQ
{
    nlines=${2:-10}
    sed -n -e :a -e "1,${nlines}!{P;N;D;};N;ba" $1
}

function psg()
{
    ps aux | grep --color=always "$1" | grep -v grep
}

function lowercase()  # move filenames to lowercase
{
    for file ; do
        filename=${file##*/} # 只保留最短的文件名
        case "$file" in
        */*) dirname=${file%/*} ;; # 取得目录名
        *) dirname=.;;
        esac
        nf=$(echo $filename | tr A-Z a-z)
        newname="${dirname}/${nf}"
        if [ "$nf" != "$filename" ]; then
            mv "$file" "$newname"
            echo "lowercase: $file --> $newname"
        else
            echo "lowercase: $file not changed."
        fi
    done
}

function swap()         # swap 2 filenames around
{
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}


#-----------------------------------
# Process/system related functions:
#-----------------------------------

function myps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; } # my_ps
function pp() { my_ps f | awk '!/awk/ && $0~var' var=${1:-".*"} ; } # ps like tree

function myip() # get IP adresses
{
    MY_IP=$(ip addr s eth2 | awk '/inet / { print $2 } ' | sed -e s/addr://)
    MY_ISP=$(/sbin/ifconfig eth2 | awk '/P-t-P/ { print $3 } ' | sed -e s/P-t-P://)
}

function ii()   # get current host related info
{
    echo -e "\nYou are logged on ${RED}$HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Machine stats :$NC " ; uptime2.sh
    echo -e "\n${RED}Memory stats :$NC " ; free -m
    myip 2>&- ;
    echo -e "\n${RED}Local IP Address :$NC" ; echo ${MY_IP:-"Not connected"}
    echo -e "\n${RED}ISP Address :$NC" ; echo ${MY_ISP:-"Not connected"}
    echo
}


function repeat()       # repeat n times command
{
    local i max
    max=$1; shift;
    for ((i=1; i <= max ; i++)); do  # --> C-like syntax
        eval "$@";
    done
}

function ask()
{
    echo -n "$@" '[y/n] ' ; read ans
    case "$ans" in
        y*|Y*) return 0 ;;
        *) return 1 ;;
    esac
}


#=========================================================================
#
# PROGRAMMABLE COMPLETION - ONLY SINCE BASH-2.04
# Most are taken from the bash 2.05 documentation and from Ian McDonalds
# 'Bash completion' package (http://www.caliban.org/bash/index.shtml#completion)
# You will in fact need bash-2.05a for some features
#
#=========================================================================

if [ "${BASH_VERSION%.*}" \< "2.05" ]; then
    echo "You will need to upgrade to version 2.05 for programmable completion"
    return
fi






#(2010年 03月 05日 星期五 18:55:55 CST)
##=============================================================================
#note:
#   !2  执行第二条历史命令

#    #!!:$ 将为当前的命令获得上一条命令的参数:
#    $ ls anaconda-ks.cfg
#    anaconda-ks.cfg
#    $ vi !!:$
#    vi anaconda-ks.cfg
#    #补充: 使用 !$ 可以达到同样的效果, 而且更简单.

#    #!^ 从上一条命令获得第一项参数:
#    $ cp anaconda-ks.cfg anaconda-ks.cfg.bak
#    anaconda-ks.cfg
#    $ vi -5 !^
#    vi anaconda-ks.cfg


#PS1="\`if [ \$? = 0 ]; then echo \[\e[33m\]^_^\[\e[0m\]; else echo \[\e[31m\]O_O\[\e[0m\]; fi\`[\u@\h:\w]\\$ " #^_^ or 0_0
#PROMPT_COMMAND='PS1="\[\033[0;33m\][\!]\`if [[ \$? = "0" ]]; then echo "\\[\\033[32m\\]"; else echo "\\[\\033[31m\\]"; fi\`[\u.\h: \`if [[ `pwd|wc -c|tr -d " "` > 18 ]]; then echo "\\W"; else echo "\\w"; fi\`]\$\[\033[0m\] "; echo -ne "\033]0;`hostname -s`:`pwd`\007"' #遇错误命令改变颜色
#PROMPT_COMMAND='PS1="\[\033[0;33m\][\!]\`if [[ \$? = "0" ]]; then echo "\\[\\033[32m\\]"; else echo "\\[\\033[31m\\]"; fi\`[\u.\h: \`if [[ `pwd|wc -c|tr -d " "` > 18 ]]; then echo "\\W"; else echo "\\w"; fi\`]\$\[\033[0m\] "; echo -ne "\033]0;:`pwd`\007"' #遇错误命令改变颜色
#PS1="\[\033[35m\]\t\[\033[m\]-\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ " #七彩提示符
#PS1="[\[\033[32m\]\w]\[\033[0m\]\n\[\033[1;36m\]\u\[\033[1;33m\]-> \[\033[0m\]" #显示完整路径
#PS1='\[\e[1;32m\]\u@\H:\[\e[m\] \[\e[1;37m\]\w\[\e[m\]\n\[\e[1;33m\]hist:\! \[\e[0;33m\] \[\e[1;31m\]jobs:\j \$\[\e[m\] ' #显示后台任务数量
#PS1='$ '
