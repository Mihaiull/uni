#!/bin/bash

# Write a shell script which takes as parameters a short month name followed by a day number (ex: Mar 8).
# (student note, the day is written as a 3 letter format so the example is not really that accurate)
# (also we give the day and the month in the reverse order that last prints them which is a little counterintuitive but alright)
# (unless of course we wanna do some input processing or maybe solve it in a different way that I didn't think of)
# The script will display all user accounts that were connected to the server that day of month.

month=$1
day=$2

last | grep "$day $month" | cut -d' ' -f1 | sort | uniq
