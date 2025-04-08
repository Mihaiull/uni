#!/bin/bash

# Write a shell script which takes as parameters several file names.
# The script will delete all words that contain at least one digit from all given files.

# Check if at least one file is provided
if [ $# -eq 0 ]; then
    echo "No files provided"
    exit 1
fi

for file in $@
do
    # Check if the file exists
    if [[ ! -f $file ]]; then
        echo "File $file does not exist."
        continue
    fi
    sed -i "s/\b\w*[0-9]\w*\b//g" $file
    # s/ - substitute (adica inlocuieste)
    # explaination of the regex:
    # \b - word boundary
    # \w* - zero or more word characters
    # [0-9] - a digit
    # so the regex matches any word that contains at least one digit
    # and replaces it with nothing
    # the -i flag is used to edit the file in place
    # the g flag is used to replace all occurrences of the regex in the file
done
