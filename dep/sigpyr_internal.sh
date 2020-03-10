#!/bin/bash

communicationFilename=$1
expectedReadySignal="ready"
until [[ "$actualReadySignal" == "$expectedReadySignal" ]]
do
  inotifywait -e modify $communicationFilename
  actualReadySignal=`tail -n1 $communicationFilename`
done

echo "You reached the end of the script file!"
# TODO: Look into returning an exit code.
