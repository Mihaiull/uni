#!/bin/bash

# Write a shell script which takes as parameters several file names.
# The script will replace the 3rd word with the 1st word in each line of the given files.
# The words shall contain only letters or numbers and shall be separated by ":".

first=$1
shift
for file in $@
do
    sed -i "s/\b\([a-zA-Z0-9]*\):[a-zA-Z0-9]*:\([a-zA-Z0-9]*\)/$first:\1:\2/g" $file
done
