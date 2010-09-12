#! /bin/sh

#  如何批量杀掉进程

ps -ef |grep java |grep -v grep |awk '{print $2}' |xargs kill -9 

