#!/bin/bash

# Write a shell script which takes as parameters a text followed by several file names.
# The script will insert the given text after the 1st line in the given files.

text=$1
shift
if [ $# -eq 0 ]
then
    echo "probably you forgot to give the files as parameters"
fi

if ! [ -f $0 ]
then
    echo "you might wanna put that text in brackets yknow"
fi

for file in $@
do
    sed -i "1 a $text" $file
    # explanation of the regex:
    # 1 - the first line
    # a - append
    # $text - the text given as a parameter
    # the -i flag is used to edit the file in place
    # so the regex appends the text after the first line
done
