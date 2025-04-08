#!/bin/bash

# Write a shell script which takes as parameters a lowercase letter followed by several file names.
# The script will replace each digit with the letter given as a parameter in all given files.

letter=$1
shift
for file in $@
do
    sed -i "s/[0-9]/$letter/g" $file
    # explanation of the regex:
    # [0-9] - any digit
    # $letter - the letter given as a parameter
    # the -i flag is used to edit the file in place
    # the g flag is used to replace all occurrences of the regex in the file
    # so the regex matches any digit and replaces it with the given letter
done
