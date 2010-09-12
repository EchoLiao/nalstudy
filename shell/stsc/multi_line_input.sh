#!/bin/bash
#Example 11-5. Multi-line input to read

echo

echo "Enter a string terminated by a \\, then press <ENTER>."
echo "Then, enter a second string, and again press <ENTER>."
read var1     # The "\" suppresses the newline, when reading $var1.
              #     first line \
              #     second line

echo "var1 = $var1"
#     var1 = first line second line

#  For each line terminated by a "\"
#+ you get a prompt on the next line to continue feeding characters into var1.

echo; echo

echo "Enter another string terminated by a \\ , then press <ENTER>."
# -r 参数使得"\"无效, 即当作普通字符读入
read -r var2  # The -r option causes the "\" to be read literally.
              #     first line \

echo "var2 = $var2"
#     var2 = first line \

# Data entry terminates with the first <ENTER>.

echo 

exit 0
