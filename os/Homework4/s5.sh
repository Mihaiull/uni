#!/bin/bash

# Write a shell script which takes as parameters several file names.
# The script will delete all words that contain at least one digit from all given files.

for file in $@
do
    sed -i "s/\b\w*[0-9]\w*\b//g" $file
    # explaination of the regex:
    # \b - word boundary
    # \w* - zero or more word characters
    # [0-9] - a digit
    # \w* - zero or more word characters
    # \b - word boundary
    # so the regex matches any word that contains at least one digit
    # and replaces it with nothing
    # the -i flag is used to edit the file in place
    # the g flag is used to replace all occurrences of the regex in the file
done
