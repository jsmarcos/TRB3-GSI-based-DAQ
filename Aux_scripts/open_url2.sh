#!/bin/bash

url=$1

while true
do
  STATUS=$(curl -s -o /dev/null -w '%{http_code}' http://$url)
  if [ $STATUS -eq 200 ]; then
    echo "Got 200! TRB3 DAQ started up. CTS web control available. Acquisitions can be done."
    break
  else
    echo "...Still waiting. Got $STATUS : TRB3 DAQ NOT prepared yet. CTS webC control NOT available yet..."
  fi
  sleep 3
done