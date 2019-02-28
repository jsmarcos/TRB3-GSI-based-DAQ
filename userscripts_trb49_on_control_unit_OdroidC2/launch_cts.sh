#!/bin/bash

export DAQOPSERVER=localhost:1 #Check if it is needed

echo "Launching cts_gui"

pkill -f "perl /home/odroid/trbsoft/daqtools/web/cts_gui"
cd /home/odroid/trbsoft/daqtools/web/
/home/odroid/trbsoft/daqtools/web/cts_gui # removed'&' in the end of the line. Jan 2019. JM
#/home/odroid/trbsoft/daqtools/web/httpi localhost 1234 &

#Load CTS configuration
#cd /home/odroid/trbsoft/userscripts/trb49/
#sh ./cts-dump-remotely.sh
