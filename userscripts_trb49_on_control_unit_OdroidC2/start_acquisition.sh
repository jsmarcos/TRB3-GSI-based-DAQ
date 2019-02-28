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

#if [[ -z "$TRBNETDPID" ]]
#then
#    ~/trbsoft/trbnettools/bin/trbnetd -i 1      #starts trbnetd which allows connection with the TRB3; trbnetd -i 1 opens a trbnetd with th$
#fi

# Take the content of the config.conf file into this shell environment: access the configurations file with TIME_ACQ, THRS_CH9 and THRS_CH10 parameters (the file is the same directory as the present script)
. config.conf

THRESHOLD_CH9=$THRS_CH9 #$2 #use $2 to get the 1st argument
THRESHOLD_CH10=$THRS_CH10 #$3 #use $3 to get the 2nd argument

#Convert thresholds do hexadecimal
THRESHOLD_CH9_HEX=$(printf '%x\n' $THRESHOLD_CH9)
THRESHOLD_CH10_HEX=$(printf '%x\n' $THRESHOLD_CH10)

$DIRBINtrbcmd2/trbcmd w 0xc310 0xa013 0x000100$THRESHOLD_CH9_HEX
$DIRBINtrbcmd2/trbcmd w 0xc311 0xa013 0x000100$THRESHOLD_CH10_HEX
sleep 1s
$DIRBINtrbcmd2/trbcmd w 0xc310 0xa013 0x000000$THRESHOLD_CH9_HEX
$DIRBINtrbcmd2/trbcmd w 0xc311 0xa013 0x000000$THRESHOLD_CH10_HEX

sleep 3s # check if it is needed
           
$DIRBINtrbcmd2/trbcmd w 0x8000 0xa101 0xffff0600
echo "acquire on"
sleep $TIME_ACQ #$1s #20s #pass as argument the time of acquisition (10 seconds in this case. For 15 minutes use: 15m). DEFAULT: seconds!
$DIRBINtrbcmd2/trbcmd w 0x8000 0xa101 0xffff0000
echo "acquire off"
