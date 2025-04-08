#!/bin/bash

# Write a shell script that takes several file names as parameters.
# The script will interchange the 1st word with the 3rd word in each line of the given files.
# The words contain only letters or numbers and are separated by any other character.
#use sed

for file in $@
do
    sed -i 's/\([a-zA-Z0-9]*\)\(.*\)\([a-zA-Z0-9]*\)\(.*\)/\3\2\1\4/g' $file
    #another spaghetti of a regex but we have seen worse:
    # \([a-zA-Z0-9]*\) - a word that contains only letters or numbers
    # \(.*\) - any character
    # /\3\2\1\4/g - the 3rd word, any character, the 1st word, any character (or at least that's the intention)
done
