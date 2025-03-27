#!/bin/bash

# Write a shell script which takes as parameters several file names.
# The script will delete all words that contain at least one digit from all given files.

for file in $@
do
    sed -i "s/\b\w*[0-9]\w*\b//g" $file
done
