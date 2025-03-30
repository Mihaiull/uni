#!/bin/bash

# Write a shell script that takes several file names as parameters.
# The script will interchange the 1st word with the 3rd word in each line of the given files.
# The words contain only letters or numbers and are separated by any other character.
#use sed

for file in $@
do
    sed -i 's/\([a-zA-Z0-9]*\)\(.*\)\([a-zA-Z0-9]*\)\(.*\)/\3\2\1\4/g' $file
done
