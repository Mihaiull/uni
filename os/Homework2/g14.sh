#!/bin/bash

# Write a shell script which takes as parameters several file names.
# The script will display all the lines in the given files that contain only uppercase letters.

for file in $@
do
    grep "^[A-Z]*$" $file
    # ^[A-Z]*$ - beginning of the line, any number of uppercase letters, end of the line
done
