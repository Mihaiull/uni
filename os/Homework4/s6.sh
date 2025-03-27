#!/bin/bash

# Write a shell script which takes as parameters a lowercase letter followed by several file names.
# The script will replace any special character with the given letter in all files given as parameters.

letter=$1
shift
for file in $@
do
    sed -i "s/[^a-zA-Z0-9]/$letter/g" $file
done
