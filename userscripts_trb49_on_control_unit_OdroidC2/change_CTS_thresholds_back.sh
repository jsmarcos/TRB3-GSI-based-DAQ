#!/bin/bash

DIRBINtrbcmd2="/home/odroid/trbsoft/trbnettools/bin"

cd /home/odroid/trbsoft/userscripts/trb49

DAQ_TOOLS_PATH=~/trbsoft/daqtools
export PATH=$PATH:$DAQ_TOOLS_PATH
export PATH=$PATH:$DAQ_TOOLS_PATH/tools

export DAQOPSERVER=localhost:1

export TRB3_SERVER=trb049:26000                 #change to the respective host name (the same than /etc/hosts)
export TRBNETDPID=$(pgrep -f "trbnetd -i 1")
#echo "- trbnetd pid: $TRBNETDPID"

THRESHOLD_CH9=$1
#echo $THRESHOLD_CH9
THRESHOLD_CH10=$2
#echo $THRESHOLD_CH10

#Convert thresholds do hexadecimal
THRESHOLD_CH9_HEX=$(printf '%x\n' $THRESHOLD_CH9)
THRESHOLD_CH10_HEX=$(printf '%x\n' $THRESHOLD_CH10)

$DIRBINtrbcmd2/trbcmd w 0xc310 0xa013 0x000100$THRESHOLD_CH9_HEX
$DIRBINtrbcmd2/trbcmd w 0xc311 0xa013 0x000100$THRESHOLD_CH10_HEX
sleep 1s
$DIRBINtrbcmd2/trbcmd w 0xc310 0xa013 0x000000$THRESHOLD_CH9_HEX
$DIRBINtrbcmd2/trbcmd w 0xc311 0xa013 0x000000$THRESHOLD_CH10_HEX
