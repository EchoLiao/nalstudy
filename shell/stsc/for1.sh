#!/bin/bash
# 列出所有的行星名称.

for planet in Mercury Venus Earth Mars Jupiter Saturn Uranus Neptune Pluto
do
  echo $planet  # 每个行星被单独打印在一行上.
done

echo

for planet in "Mercury Venus Earth Mars Jupiter Saturn Uranus Neptune Pluto"
# 所有的行星名称打印在同一行上.
# 整个'list'只有一个变量，用""封成一个变量.
do
  echo $planet
done

exit 0
