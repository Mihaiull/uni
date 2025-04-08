#!/bin/bash
# Write a shell script which takes as parameters a file name followed by several words.
# The script will delete all occurrences of the words given as parameters in the given file.

filename=$1
shift
for word in $@
do
    sed -i "s/$word//g" $filename #"s/$word//g" does the replacement, i googled it so it must be true
    # s/ - substitute command
    # $word - the word to be replaced
    # // - replace with nothing
    # g - replace all occurrences
    # sanatate
done
