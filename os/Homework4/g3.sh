#!/bin/sh

#Write a shell script which takes as parameters a few directory names.
#The script will display the names of all binary files in the given directories and their subdirectories.

for dir in $@
do
    find $dir -type f -exec file {} \; | grep -i "executable"
done
