#!/bin/bash
# alarm.sh
# Auto suspend and wake-up script
#
# Puts the computer on standby and automatically wakes it up at
# specified time.
#
# Written by Romke van der Meulen <redge.online@gmail.com>
# Minor mods by fossfreedom for AskUbuntu
# Minor mods by Brandon Amos <http://bamos.github.com> for default
# time and cleaner code.

# Sets the desired time for the next occuring time
# so the desired time isn't before $NOW
function set_desired {
    NOW=$(date +%s)
    DESIRED=$(date +%s -d "$*")
    if [ $DESIRED -lt $NOW ]; then
        DESIRED=$(date +%s -d "tomorrow $*")
    fi
}

# If nothing is passed as a parameter, default to the next
# occuring 5:00, otherwise, read the first parameter
if [ $# -lt 1 ]; then
    set_desired 5:00
else
    set_desired $@
fi

# Kill rtcwake (if necessary) and call it again
killall rtcwake > /dev/null 2>&1
rtcwake -m mem -t $DESIRED
