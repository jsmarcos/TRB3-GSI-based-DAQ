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

$DIRBINtrbcmd2/trbcmd w 0x8000 0xa101 0xffff0000
echo "acquire off"
