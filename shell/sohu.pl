#!/usr/bin/perl
#
# http://forum.ubuntu.org.cn/viewtopic.php?f=74&t=373840
#

# ./sohu.pl http://tv.sohu.com/20120423/n341373708.shtml

# mplayer http://newflv.sohu.ccgslb.net/60/144/yqGK9oaC1hwq3BcD1M3nc3.mp4
#         http://newflv.sohu.ccgslb.net/71/47/zgFZX7jX9Mc6sPjXFK4Gc5.mp4
#         http://newflv.sohu.ccgslb.net/44/202/47Wo6Fc4WsJEvfJjhlslk7.mp4


use strict;
use LWP::Simple;


my $arg=$ARGV[0];
#$arg = "http://tv.sohu.com/20120423/n341373708.shtml";
my $url="http://www.flvcd.com/parse.php?format=high&kw=$arg";
#(如果有的话)
#format=high 	高清版解析
#format=super 	超清版解析
#format=real   	原画版解析

(my  @flvurls)=get($url)=~/<U>(.*)/g;
foreach my $flvurl (@flvurls) {
    my($tmp ,$url) = split(/=/,$flvurl);

    print "http://newflv.sohu.ccgslb.net$url\n";
    system("mplayer","http://newflv.sohu.ccgslb.net$url");
}

