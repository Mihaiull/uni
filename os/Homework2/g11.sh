#!/bin/bash

# Write a shell script which takes as parameters several user accounts (ex: gmae0221 jpae0229).
# The script will display those user accounts (from those given as parameters) that have never been connected to the server.
# slightly different but still the same ideea as g9.sh

for user in $@
do
    if [ $(last | grep $user | wc -l) -eq 0 ]
    then
        echo $user
    fi
done
