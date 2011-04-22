#!/bin/sh

if [[ `/bin/df | grep win_bk_dir` && `/bin/df | grep win_rsync_dir` ]]; then
    echo -n "rsync /var/svn/ to windows ... "
    /home/sre/bin/rsync.sh -s /var/svn/ -d /media/win_rsync_dir/ \
         -k -b /media/win_bk_dir/ -u -a -r >/dev/null 2>&1
    echo "done."
else
    echo "请选挂载备份盘(win_rsync_dir)"
fi


# /home/sre/bin/rsync.sh /home/sre/notes/ -d /media/LB/gs/linux/rsync/ -k -b /media/LB/gs/linux/bk/ -u -a -r


exit 0
