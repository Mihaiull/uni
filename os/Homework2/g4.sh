#!/bin/bash

# Write a shell script that takes a group name (ex: gr821) as a parameter.
# The script will display the given group name followed by the list of all users that belong to that group.
# using grep

group=$1
grep $group /etc/group | cut -d: -f4 | tr ',' '\n'
