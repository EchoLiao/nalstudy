#!/bin/bash

pid=`ps aux | grep mentohust | awk '{print $2}'`
pid1=`echo $pid | awk '{print $1}'`
user=`ps aux | grep mentohust | awk '{print $1}'`
user1=`echo $user | awk '{print $1}'`
#echo $user1

for ((i=0; i==0; ))
do
	clear
	echo "               ^_^欢迎使用NAL锐捷客户端^)_(^"
	echo "               -----------------------------"
	echo "               Choose one of the following:"
	echo "               [y]打开锐捷"
	echo "               [n]关闭锐捷"
	echo -n ">>>>>: "
	read answer
	case "$answer" in
	[yY])	i=1;
			if [ "$user1" != "root" ]; then
				mentohust -b3;
				echo; echo ">>>>>>>锐捷连接成功>>>>>>>!!!";
			else
				echo "&&&&&&&Error: 锐捷已连接(锐捷已运行中)!!!"
			fi;;
	[nN])	i=1;
			if [ "$user1" == "root" ]; then
				#kill $pid1
				mentohust -k
				echo "<<<<<yeah!!^_^  已成功关闭锐捷!!!"
			else
				echo "&&&&&&&Error: 锐捷还未连接!!"
			fi;;
	   *);;
	esac
done

echo
#echo "请按任意键退出终端^_^"
# /usr/local/nat/nat.sh
sleep 10
exit 0
