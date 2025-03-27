#!/bin/bash

# Write a shell script which takes as parameter a directory name.
# The script will display the content of all text files in the given directory and its subdirectories.

dir=$1

# for file in $(find $dir -type f -name "*.txt")
# do
#    cat $file                                              # works but i need to use grep
# done

grep -r -o -i -w -E "[a-zA-Z]+" $dir
