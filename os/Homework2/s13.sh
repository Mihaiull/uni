#!/bin/bash

# Write a shell script which takes as parameters several file names.
# The script will delete the first 2 characters on each line in the given files.

for file in $@
do
    sed -i "s/^..//" $file
    # .. - any 2 characters
    # ^ - beginning of the line
    # pretty simple
done
