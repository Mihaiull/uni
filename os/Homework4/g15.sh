#!/bin/bash

# Write a shell script which takes as parameters several file names.
# The script will display all the lines in the given files that contain only lowercase letters.

for file in $@
do
    grep "^[a-z]*$" $file
    # ^[a-z]*$ - beginning of the line, any number of lowercase letters, end of the line
done
