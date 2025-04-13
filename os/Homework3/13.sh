#!/bin/bash

# Write a shell script that takes as parameters a short month name followed by a day number and a time interval (ex: Mar 8 11.00-12.00).
# The script will display the usernames and the total number of users that were connected to the server on that date and within that time frame
# using awk

# FUCK THIS SHIT

if [ $# -ne 3 ]; then
    echo "Usage: $0 <Month> <Day> <HH.MM-HH.MM>"
    exit 1
fi

MONTH=$1
DAY=$2
RANGE=$3

START_HOUR=${RANGE%-*}
END_HOUR=${RANGE#*-}

# Convert to HH:MM
START_TIME=$(echo "$START_HOUR" | awk -F. '{printf("%02d:%02d", $1, $2)}') # -F specifies . as field separator - needed for splitting start_hour & end_hour into hour and minute components
END_TIME=$(echo "$END_HOUR" | awk -F. '{printf("%02d:%02d", $1, $2)}') # the ugly ass %02d is just the way printf formats numbers as a 2 digit number with leading 0s if needed

last | awk -v month="$MONTH" -v day="$DAY" -v start="$START_TIME" -v end="$END_TIME" '
function time_to_minutes(t) {   #easier to just make a function
    split(t, parts, ":")    #simple, split parts using : as separator
    return parts[1]*60 + parts[2]
}

{
    if ($0 ~ month " " day) {   ## if month and day match the pattern in $0 (the current line)
        user = $1

        # Extract login and logout times
        match($0, /[A-Z][a-z]{2} [ 0-9]{1,2} ([0-9]{2}:[0-9]{2}) - ([0-9]{2}:[0-9]{2}|still logged in)/, times) #i gave up un the fucking columns since last has so many varying columns its so fucking shit fuck everything
        #regex never fails me
        #[A-Z][a-z]{2} - Matches three letters starting with capital letter (month abbreviation) - Ex: Jan, Feb, Mar
        #[ 0-9]{1,2} - Matches one or two digits (day number) with optional space in front # Ex: 3 or  1 or 12
        #([0-9]{2}:[0-9]{2}|still logged in)/ - # Matches either a time in HH:MM format or the text "still logged in"
        # times - is an array holding the matched text:
        # times[0] - the full match
        # times[1] - login time
        # times[2] - logout time

        if (times[1] == "") next    #obviously

        login_time = times[1]
        logout_time = times[2]

        login_min = time_to_minutes(login_time)
        start_min = time_to_minutes(start)
        end_min = time_to_minutes(end)

        if (logout_time == "still logged in") {
            logout_min = 1440  # assume end of day (1440 is not a display resolution, its 24*60)
        } else {
            logout_min = time_to_minutes(logout_time)
        }

        # Overlapping time intervals
        if ((login_min <= end_min) && (logout_min >= start_min)) {
            users[user]++   #users is an associative array, awk automatically creates it if it doesnt exist, macar atat
            total++
        }
    }
}

END {   #END block is executed after all input lines have been processed
    print "Users connected in given interval:"
    for (u in users) {
        print u
    }
    print "Total number of connections: " total
}
'

# sorry not sorry but this is not a problem to give to absolute begginers, even I (which I am not some big shit but I like to think I know my way around this stuff) struggled with it
# conclusion: the awk collumns are unreliable as fuck and we should just all learn regex fucking waste of time
