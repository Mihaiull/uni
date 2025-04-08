#!/bin/bash

# Write a shell script which takes as parameters a file name followed by several directory names.
# The script will delete all files whose names are given in the file received as first parameter in the given directories and their subdirectories.

filename=$1
shift

for dir in $@
do
    find $dir -type f | while read file
    do
        if grep -q $(basename $file) $filename
        then
            rm $file
        fi
    done
done
