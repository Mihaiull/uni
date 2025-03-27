#!/bin/bash

#Write a shell script which takes as parameters a word followed by several file names.
#The shell will delete all the lines containing the given word in all given files.

word=$1
shift
for file in $@
do
    sed -i "/$word/d" $file
done
