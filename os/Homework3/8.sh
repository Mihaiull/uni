#!/bin/bash

# Write a shell script which takes as parameters two file names (a file that
# contains user names and a file that contains any text). The script will send a
# mail to each user in the first file (the mail message will be the text in the
# second file).
#

users_file="$1"
text_file="$2"

while read -r user; do
    mail -s "bulk mail" "$user" < "$text_file"
done < $users_file
