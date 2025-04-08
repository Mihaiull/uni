#!/bin/bash

# Write a shell script which takes as parameters a word followed by several file names.
# The shell will display the names of the files containing the given word and the total number of these files.

word=$1
shift
count=0
for file in $@
do
    if grep -q -w $word $file
    then
        echo $file
        count=$((count+1))
    fi
done

echo "count: $count"
