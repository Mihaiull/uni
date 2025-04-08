#!/bin/sh

# Write a shell script which takes as parameters several file names.
# The script will display all the lines in the given files that don't contain any letter or digit.

for file in $@
do
    grep -v "[a-zA-Z0-9]" $file
    # [a-zA-Z0-9] - any letter or digit
    # -v - display the lines that don't match the regex
done
