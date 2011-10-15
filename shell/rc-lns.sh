
#/home/scr/.rt/vercol/git/rc-files

# PASSWORD
# ~/.getmail/
# ~/.msmtprc

w=`whoami`

if [[ $w == "root" ]]; then

ln -f -s .rt/vercol/git/rc-files/rt/etc/hosts              /etc/hosts

else

ln -f -s .rt/vercol/git/rc-files/rt/home/scr/.bash_history /home/scr/.bash_history
ln -f -s .rt/vercol/git/rc-files/rt/home/scr/.bash_logout  /home/scr/.bash_logout
ln -f -s .rt/vercol/git/rc-files/rt/home/scr/.bash_profile /home/scr/.bash_profile
ln -f -s .rt/vercol/git/rc-files/rt/home/scr/.bashrc       /home/scr/.bashrc
ln -f -s .rt/vercol/git/rc-files/rt/home/scr/.inputrc      /home/scr/.inputrc
ln -f -s .rt/vercol/git/rc-files/rt/home/scr/.mailcap      /home/scr/.mailcap
ln -f -s .rt/vercol/git/rc-files/rt/home/scr/.muttrc       /home/scr/.muttrc
ln -f -s .rt/vercol/git/rc-files/rt/home/scr/.screenrc     /home/scr/.screenrc

fi

