#!/bin/bash

#Write a shell script which takes as parameters an uppercase letter followed by several file names.
#The script will add the given letter in the front of each lowercase on each line in all given files.t

letter=$1
shift
for file in $@
do
    sed -i "s/\b\([a-z]\)/$letter\1/g" $file
    # pretty straight forward
    # s/ - substitute command
    # \b - word boundary \([a-z]\) - lowercase letter
    # \1 - the lowercase letter matched by the regex
done
