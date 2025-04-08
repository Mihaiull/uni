#!/bin/bash

# Write a shell script which takes as parameters a lowercase letter followed by several file names.
# The script will replace any special character with the given letter in all files given as parameters.

letter=$1
shift
for file in $@
do
    sed -i "s/[^a-zA-Z0-9]/$letter/g" $file
    # explanation of the regex:
    # [^a-zA-Z0-9] - any character that is not a letter or a digit
    # $letter - the letter given as a parameter
    # the -i flag is used to edit the file in place
    # the g flag is used to replace all occurrences of the regex in the file
    # so the regex matches any special character and replaces it with the given letter
    # the command will replace all special characters with the given letter in all files given as parameters
done
