#!/bin/bash

# Write a shell script which takes as parameters several file names. The script will delete the 2nd and 4th word in each line of the given files.
# The words shall contain only letters or numbers and shall be separated by spaces.

for file in $@; do
    if [ -f $file ]; then
        sed -i 's/\b\w\+\b//2' $file
        sed -i 's/\b\w\+\b//4' $file
        # explanation of the regex:
        # \b - word boundary
        # \w\+ - one or more word characters
        # \b - word boundary
        # //$number - the number of the word to be deleted
    else
        echo "$file is not a file." #because I did indeed try to feed it a directory for... testing purposes
    fi
done
