#!/bin/bash

# Write a shell script that reads user names from keyboard. For each user, the
# script will display the number of times it was logged in to the server in the
# current month. If he/she has not logged in at all during the current month, the
# script will display the message: "User X has never logged in during the current
# month".
#
# The script will stop when the user enters the string "exit".

username=$1
month=$(date +%b) #last gives month in 3 letter format so don't use +%m
year=$(date +%Y)
login_count=$(last -F | grep -c "^$username.*$month.*$year") # .* to match any characters between month and year / ^ to match beginning of line

if [ "$login_count" -gt 0 ]; then
       echo "User $username has logged in $login_count times during the current month."
   else
       echo "User $username has never logged in during the current month."
   fi
