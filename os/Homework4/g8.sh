#!/bin/bash

# Write a shell script which takes as parameters several user accounts (ex: gmae0221 jpae0229). WHY IS MY USERNAME IN THE EXAMPLES?????
#  The script will display those user accounts (from those given as parameters) that are currently connected to the server.

# Check if the user is root or not
if [ $UID -ne 0 ]; then
    echo "You must be root to run this script."
    exit 1
fi
# if you're not root, you can't run this script because you can't see other users' processes

for user in $@; do
    who | grep $user
done
