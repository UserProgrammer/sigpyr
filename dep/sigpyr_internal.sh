#!/bin/bash

communicationFilename=".sigpyr_comm_file"
expectedReadySignal="ready"
until [[ "$actualReadySignal" == "$expectedReadySignal" ]]
do
  inotifywait -e modify $communicationFilename
  actualReadySignal=`tail -n1 $communicationFilename`
done

echo "You reached the end of the script file!"
# TODO: Look into returning an exit code.
