#!/bin/bash

temp=$( realpath "$0" ) && absolutePathToMainScriptFile=$( dirname "$temp" )
TIMEOUT="${absolutePathToMainScriptFile}/dep/timeout.sh"

TIMEOUT_PERIOD_IN_SECONDS=5
PORT_NUMBER=4444
SIGNAL="ready"

POSITIONAL=()
while [[ $# -gt 0 ]]
do
  key="$1"

  case $key in
    -p|--port)
      PORT_NUMBER="$2"
      shift
      shift
      ;;
    -t|--timeout)
      TIMEOUT_PERIOD_IN_SECONDS="$2"
      shift
      shift
      ;;
    -s|--signal)
      SIGNAL="$2"
      shift
      shift
      ;;
    *)
      POSITIONAL+=("$1")
      shift
      ;;
  esac
done

set -- "{$POSITIONAL[@]}"

if [ `netstat -ant | awk -v pattern="[^0-9]$PORT_NUMBER$" '$6 == "LISTEN" && $4 ~ pattern' | wc -l` != 0 ]
then
  echo "port $PORT_NUMBER is already in use"
  exit 1
fi

# TODO: This should be generated in a method.
MILLISECONDS_SINCE_EPOCH=$(( $(date '+%s%N') / 1000000));
COMMUNICATION_FILENAME=".signpyr_comm_file_$MILLISECONDS_SINCE_EPOCH"

nc -lvvdp $PORT_NUMBER > $COMMUNICATION_FILENAME &

$TIMEOUT -t $TIMEOUT_PERIOD_IN_SECONDS ${absolutePathToMainScriptFile}/dep/sigpyr_internal.sh $COMMUNICATION_FILENAME

pkill -fx "nc -lvvdp 4444"
rm -f $COMMUNICATION_FILENAME
