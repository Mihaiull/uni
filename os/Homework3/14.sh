#!/bin/bash

# Write a shell script which
# displays all files in the current directory and its subdirectories
# that have write permission for the group of which the owner belongs.
#

files=$(find . -type f -perm -g=w)

for file in $files; do
    echo $file
done
