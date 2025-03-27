#!/bin/bash

# Write a shell script which takes as parameters a text followed by several file names.
# The script will delete all the lines which contain the text given as parameter in all given files.

text=$1
shift
for file in $@
do
    sed -i "/$text/d" $file
done
