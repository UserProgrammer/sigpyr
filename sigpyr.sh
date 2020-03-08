#!/bin/bash

TIMEOUT=./dep/timeout.sh

#TODO: If I'm going to keep this script in this folder, I should include the current time in milliseconds in the filename, that way if the script is executed multiple times, the filenames wont clash.
communicationFilename=".sigpyr_comm_file"
nc -lvvdp 4444 > $communicationFilename &

$TIMEOUT -t 5 ./dep/sigpyr_internal.sh

pkill -fx "nc -lvvdp 4444"
rm -f $communicationFilename
