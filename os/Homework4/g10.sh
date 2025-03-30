#!/bin/bash

# Write a shell script which takes as parameters several user accounts (ex: gmae0221 jpae0229).
# The script will display all directories in each user's home directory that have write permission for the group of which the owner belongs.

for user in $@
do
    for dir in $(ls -l /home/$user | grep "^d" | awk '{print $9}')
    do
        if [ -w /home/$user/$dir ]
        then
            echo $dir
        fi
    done
done
