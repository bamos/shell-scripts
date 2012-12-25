#!/bin/bash
# alarm.sh
# Auto suspend and wake-up script
#
# Puts the computer on standby and automatically wakes it up at specified time
#
# Written by Romke van der Meulen <redge.online@gmail.com>
# Minor mods fossfreedom for AskUbuntu
# Minor mods by Brandon Amos <http://www.brandonamos.org> for default time and cleaner code

# Sets the desired time for the next occuring time
# so the desired time isn't before $NOW
set_desired() {
    NOW=$((`date +%s`))
    DESIRED=$((`date +%s -d "$1"`))
    if [ $DESIRED -lt $NOW ]; then
        DESIRED=$((`date +%s -d "tomorrow $1"`))
    fi
}

# If nothing is passed as a parameter, default to the next 
# occuring 5:00, otherwise, read the first parameter
if [ $# -lt 1 ]; then
    set_desired 5:00
else
    set_desired $(echo -n "$1$2")
fi

# Kill rtcwake (if necessary) and call it again
killall rtcwake > /dev/null 2>&1
rtcwake -l -m mem -t $DESIRED

# Turn off the display after waking
xset dpms force off
