#!/bin/bash

# Write a shell script that takes as parameters a short month name followed by a day number and a time interval (ex: Mar 8 11.00-12.00).
# The script will display the usernames and the total number of users that were connected to the server on that date and within that time frame
# using awk

month=$1
day=$2
time_interval=$3

#get start time and end time
start_time=$(echo "$time_interval" | cut -d '-' -f 1)
end_time=$(echo "$time_interval" | cut -d '-' -f 2)

#i got the exact format that last prints so now it's just down to checking collumns


echo $(last | awk -v month="$month" -v day="$day" -v start_time="$start_time" -v end_time="$end_time" '
{
    #check for the month and day (month on the 3rd column and day number on the 6th) this breaks when reading a system boot entry... I don t really like awk
    if ($3 == month && $6 == day) {
        #check for the time interval (time on the 4th column)
        split($4, time, ":")
        start_time_split = split(start_time, start_time_arr, ".")
        end_time_split = split(end_time, end_time_arr, ".")

        #convert to minutes
        start_time_minutes = start_time_arr[1] * 60 + start_time_arr[2]
        end_time_minutes = end_time_arr[1] * 60 + end_time_arr[2]
        time_minutes = time[1] * 60 + time[2]

        if (time_minutes >= start_time_minutes && time_minutes <= end_time_minutes) {
            print $1
            count++
        }
    }
}')
