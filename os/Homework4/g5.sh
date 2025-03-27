#!/bin/bash

# Write a shell script that takes a command name (ex: ping) as a parameter.
# The script will display all user accounts running the given command.

command=$1

ps aux | grep $command | cut -d' ' -f1 | sort | uniq
