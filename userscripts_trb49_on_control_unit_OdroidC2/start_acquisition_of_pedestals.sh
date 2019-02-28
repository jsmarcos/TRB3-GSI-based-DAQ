#!/bin/bash

DIRBINtrbcmd2="/home/odroid/trbsoft/trbnettools/bin"

#test
cd /home/odroid/trbsoft/userscripts/trb49

DAQ_TOOLS_PATH=~/trbsoft/daqtools
export PATH=$PATH:$DAQ_TOOLS_PATH
export PATH=$PATH:$DAQ_TOOLS_PATH/tools

export DAQOPSERVER=localhost:1

export TRB3_SERVER=trb049:26000                 #change to the respective host name (the same than /etc/hosts)
export TRBNETDPID=$(pgrep -f "trbnetd -i 1")
echo "- trbnetd pid: $TRBNETDPID"

# Take the content of the config.conf file into this shell environment: access the configurations file with TIME_ACQ, THRS_CH9 and THRS_CH10 parameters (the file is the same directory as the present script)
. config.conf
           
$DIRBINtrbcmd2/trbcmd w 0x8000 0xa101 0xffff0004
echo "acquire on. Recording pedestals during $1 seconds..."
sleep $TIME_ACQ  #$1s #20s #pass as argument the time of acquisition (10 seconds in this case. For 15 minutes use: 15m). Default time unit: seconds
$DIRBINtrbcmd2/trbcmd w 0x8000 0xa101 0xffff0000
echo "acquire off"
