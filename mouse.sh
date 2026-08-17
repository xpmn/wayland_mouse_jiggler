#!/bin/bash

# Find first mouse event device using /proc/bus/input/devices
_dev=$(awk '
    /Name=.*[Mm]ouse/ { in_mouse=1 }
    /Handlers=/ && in_mouse {
        for (i=1;i<=NF;i++)
            if ($i ~ /^event[0-9]+$/) {
                print "/dev/input/" $i
                exit
            }
    }
    /^$/ { in_mouse=0 }
' /proc/bus/input/devices)

[ -z "$_dev" ] && echo "Cannot find mouse event device" && exit 1

echo "Using $_dev"

while true; do
    sleep 1
    /usr/bin/evemu-event "$_dev" --type EV_REL --code REL_X --value $(( RANDOM % 50 + 1 - 25 )) --sync
    /usr/bin/evemu-event "$_dev" --type EV_REL --code REL_Y --value $(( RANDOM % 50 + 1 - 25 )) --sync
    echo -n "#"
done

