#!/bin/bash

# Write a shell script which takes as parameters several file names.
# The script will replace all lowercase vowels with corresponding uppercase letters in each line of the given files.

for file in $@
do
    sed -i "s/[aeiou]/\U&/g" $file
done
