#!/bin/bash
# Write a shell script which takes as parameter an existing
# group number (ex: 821).
# The script will display the details about that group.

group=$1
group_info=$(getent group $group)

echo "Group details:" $group_info
