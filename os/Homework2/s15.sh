#!/bin/bash

# Write a shell script which takes as parameters several file names.
# The script will delete the last 3 characters on each line in the given files.

for file in $@
do
    sed -i "s/...$//" $file
    # ... - any 3 characters
    # $ - end of the line
    # pretty simple
done
