#!/bin/bash

# Write a shell script which takes as parameter a directory name. The script will
# determine the total number of lines in all ASCII text files in this directory
# and its subdirectories. It is assumed that any directory will only contain
# ASCII text files.

#is the argument a directory
if [ ! -d "$1" ]; then
    echo "Error: $1 is not a directory."
    exit 1
fi

files=$(find "$1" -type f -exec file {} \; | grep -i 'ascii text' | cut -d: -f1)

for file in $files; do
    lines=$(wc -l < "$file")
    total=$((total + lines))
done

echo "Total : $total lines"
