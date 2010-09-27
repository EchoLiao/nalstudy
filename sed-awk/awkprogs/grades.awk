# Name: grades.awk
# Usage: awk -f grades.awk infile
# Description: average student grades and determine
#   letter grade as well as class averages.

# grades.awk: average student grades and determine
# letter grade as well as class averages.
# $1 = student name; $2 - $NF = test scores.

# usage: awk -f grades.awk grades.test

# (数组)

# set output field separator to tab.
BEGIN { OFS = "\t" }

# action applied to all input lines
{
    # add up grades
    total = 0
    for (i = 2; i <= NF; ++i)
        total += $i
    # calculate average
    avg = total / (NF - 1)
    # assign student's average to element of array
    class_avg[NR] = avg
    # determine letter grade
    if (avg >= 90)  grade="A"
    else if (avg >= 80) grade="B"
    else if (avg >= 70) grade="C"
    else if (avg >= 60) grade="D"
    else grade="F"
    # increment counter for letter grade array
    ++class_grade[grade]
    # print student name, average and letter grade
    print $1, avg, grade
}

# print out class statistics
END {
    # calculate class average
    for( x = 1; x <= NR; x++)
        class_avg_total += class_avg[x]
    class_average =  class_avg_total / NR
    # determine how many above/below average
    for( x = 1; x <= NR; x++)
        if (class_avg[x] >= class_average)
        ++above_average
    else
        ++below_average
    # print results
    print ""
    print "Class Average: ", class_average
    print "At or Above Average: ", above_average
    print "Below Average: ", below_average
    # print number of students per letter grade
    for (item in class_grade) # (组合其它工具)
        print item ":", class_grade[item] | "sort -r" # 可以不要 | "sort"
        # for 会自动将下标排序
}
