#!/bin/bash

# Write a shell script which takes as parameters several file names.
# The script will replace the 3rd word with the 1st word in each line of the given files.
# The words shall contain only letters or numbers and shall be separated by ":".
# #example: word1:word2:word3:word4:word5
#           word3:word2:word1:word4:word5

for file in $@
do
    #i like shooting myself in the foot and then trying to walk
    sed -i "s/\([a-zA-Z0-9]*\):[a-zA-Z0-9]*:\([a-zA-Z0-9]*\):[a-zA-Z0-9]*:[a-zA-Z0-9]*/\1:\2:\1/g" $file
done

# Fair warning, all the words after the 8'th one on each line get deleted. Why? Good question. Probably because I'm a moron.
