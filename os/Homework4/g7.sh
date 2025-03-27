#!/bin/bash

# Write a shell script which takes as parameters several host names (ex: www.cs.ubbcluj.ro www.google.ro).
# The script will display the host names (from those given as parameters) that are alive. Use the ping command to verify that a given host is alive.

for host in $@
do
    ping -c 1 $host > /dev/null
    if [ $? -eq 0 ]
    then
        echo $host
    fi
done

# it is slow because it waits for the ping command to finish
