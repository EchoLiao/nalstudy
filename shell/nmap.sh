#!/bin/bash

# this file had put in crontab to run on time

suffix=$(date +%Y-%m-%d.%H.%M.%S)  # 'date'命令的 "+%s" 选项是 GNU-特性.

#touch tmp_$suffix

# 扫描网段, 并试着查出其操作系统类型(-O)
nmap -sS -O 10.3.10.254/24 > /tmp/nmap/10.3.10.0-24_$suffix.txt
nmap -sS -O 10.3.0.254/24 > /tmp/nmap/10.3.0.254-24_$suffix.txt
nmap -sS -O 10.3.1.254/24 > /tmp/nmap/10.3.1.254-24_$suffix.txt
nmap -sS -O 10.3.2.254/24 > /tmp/nmap/10.3.2.254-24_$suffix.txt
nmap -sS -O 10.3.3.254/24 > /tmp/nmap/10.3.3.254-24_$suffix.txt
nmap -sS -O 10.3.4.254/24 > /tmp/nmap/10.3.4.254-24_$suffix.txt
nmap -sS -O 10.3.5.254/24 > /tmp/nmap/10.3.5.254-24_$suffix.txt
nmap -sS -O 10.3.6.254/24 > /tmp/nmap/10.3.6.254-24_$suffix.txt
nmap -sS -O 10.3.7.254/24 > /tmp/nmap/10.3.7.254-24_$suffix.txt
nmap -sS -O 10.3.8.254/24 > /tmp/nmap/10.3.8.254-24_$suffix.txt
nmap -sS -O 10.3.9.254/24 > /tmp/nmap/10.3.9.254-24_$suffix.txt

nmap -sS -O 10.0.3.254/24 > /tmp/nmap/10.0.3.254-24_$suffix.txt
nmap -sS -O 10.0.0.254/24 > /tmp/nmap/10.0.0.254-24_$suffix.txt
nmap -sS -O 10.0.1.254/24 > /tmp/nmap/10.0.1.254-24_$suffix.txt

nmap -sS -O 123.232.96.209/24 > /tmp/nmap/123.232.96.209-24_$suffix.txt
nmap -sS -O 123.232.96.209/16 > /tmp/nmap/123.232.96.209-16_$suffix.txt
