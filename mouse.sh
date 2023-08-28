#!/bin/bash
_dev=$(ls -1 /dev/input/by-id/*event-mouse | tail -1)
[ -z "${_dev}" ] && echo "Cannot find mouse event device" && exit 1
echo "Using ${_dev}"
while [ true ]
do
        sleep 1
        /usr/bin/evemu-event ${_dev} --type EV_REL --code REL_X --value $(( $RANDOM % 50 + 1 - 25 )) --sync
        /usr/bin/evemu-event ${_dev} --type EV_REL --code REL_Y --value $(( $RANDOM % 50 + 1 - 25 )) --sync
        echo -n "#"
done