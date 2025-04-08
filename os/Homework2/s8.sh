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
    # explanation of the regex: (i need it for myself at this point)
    # \([a-zA-Z0-9]*\) - a word that contains only letters or numbers
    # : word separator as stated in the problem
    # /\1:\2:\1/g - the 1st word, the 2nd word, the 1st word
    # the -i flag is used to edit the file in place
    # the g flag is used to replace all occurrences of the regex in the file
    # so the regex matches the 3rd word and replaces it with the 1st word in all lines of the file
done

# Fair warning, all the words after the 8'th one on each line get deleted. Why? Good question. Probably because I'm a moron.
