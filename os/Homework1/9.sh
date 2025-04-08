#!/bin/bash
# Write a shell script which takes as parameter a username.
# The script will count and display the number of processes
# that belong to that user.

user=$1
processes=$(ps -u $user | wc -l)
echo "Number of processes for user $user: $((processes - 1))"
