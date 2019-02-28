#!/bin/bash

#sleep 60
cd /home/odroid/trbsoft/userscripts/trb49


#to run the script from the crontab:
if [[ -x ~/.bashrc ]]; then
    chmod a+x ~/.bashrc
fi
PS1='$ '; source ~/.bashrc


DAQ_TOOLS_PATH=~/trbsoft/daqtools
export PATH=$PATH:$DAQ_TOOLS_PATH
export PATH=$PATH:$DAQ_TOOLS_PATH/tools

export DAQOPSERVER=localhost:1

#export TRB3_SERVER=trb012:26000                 #change to the respective host name (the same than /etc/hosts)
export TRB3_SERVER=trb049:26000                 #change to the respective host name (the same than /etc/hosts)
export TRBNETDPID=$(pgrep -f "trbnetd -i 1")
echo "- trbnetd pid: $TRBNETDPID"

if [[ -z "$TRBNETDPID" ]]
then
    ~/trbsoft/trbnettools/bin/trbnetd -i 1      #starts trbnetd which allows connection with the TRB3; trbnetd -i 1 opens a trbnetd with th$
fi

./check_ping.pl					#ping the TRB, the script must be changed accordingly with the respective TRB name

echo "reset"
./trbreset_loop.pl				#the # of endpoints must be changed accordingly (5 endpoints for 1 TRB)
sleep 1;

trbcmd i 0xffff
#trbcmd s 0x12000002e2d98d28 0x05 0xc001 #CTS TRB12
#trbcmd s 0xcf000003480d8a28 0x00 0xa001 #ADA1
#trbcmd s 0x99000002e30e5728 0x01 0xa002 #ADA2
#trbcmd s 0x4e000002e2e24c28 0x02 0xa003 #ADA3
#trbcmd s 0x6a000002e2e24328 0x03 0xa004 #not used
trbcmd s 0x6a000006e95d3528 0x00 0xC310 #ADC
trbcmd s 0xef000006e95d3228 0x01 0xC311 #ADC
trbcmd s 0xcf000006e95d1b28 0x02 0xC312 #not used
trbcmd s 0xb1000006e9545028 0x03 0xC313 #not used
trbcmd s 0x96000006e95d1828 0x05 0x8000 #CTS TRB49

trbcmd i 0xffff



echo "GbE settings"
loadregisterdb.pl db/register_configgbe.db	#must be changed accordingly (ID of the CTS_FPGA as defined above)
loadregisterdb.pl db/register_configgbe_ip.db	#must be changed accordingly (DAQ_MAC + IP + Dest Port (used in EventBuilder_TRB186.xml))

#echo "TDC settings"
loadregisterdb.pl db/register_configtdc.db	#must be changed accordingly (ID of the TDC_FPGAs as defined above)
#echo "TDC settings end"

#echo "pulser"
# pulser #0 to 10 kHz
# trbcmd w 0xc001 0xa156 0x4e20	  # 0x4268 = 17000 -> 170000 ns = 0.170ms -> 5.88 kHz (1ADC + 1 TDC -> 87MB/s, 8% of deadtime)

#echo "pulser enable"
# pulser enable
# trbcmd setbit 0xc001 0xa101 0x2

# JM commented the three commands below, from Alberto/João Saraiva group
#echo "start trigger"
#trbcmd w 0xc001 0xa101 0xffff4000	#enable ch14 (coincidence module 0) trg_channel_mask: edge=1111 1111 1111 1111, mask=0000 0000 0010 0000

#echo "start coincidences with detector 1&3"
#trbcmd w 0xc001 0xa13e 0x30005		#trg_coin_config0: coin_mask=0000 0101, inhibit_mask=0000 0000; window=3 = 30 ns 

#echo "limit cts_throttle"
#trbcmd w 0xc001 0xa00c 0x00000401  # cts_throttle: enable=true, stop=false, threshold=1


#Threshold Settings - Below some settings of Alberto/João Saraiva group
#~/trbsoft/daqtools/tools/dac_program.pl ~/trbsoft/userscripts/trb12/thresholds/configFile_a001_40mv
#~/trbsoft/daqtools/tools/dac_program.pl ~/trbsoft/userscripts/trb12/thresholds/configFile_a002_40mv
#~/trbsoft/daqtools/tools/dac_program.pl ~/trbsoft/userscripts/trb12/thresholds/configFile_a003_40mv

#setup ADC addon
Samples=30
SamplesAfterTrigger=60
Threshold_Ch9=80
Threshold_Ch100=220

FPGA="0xC310"
~/trbsoft/daqtools/tools/adc.pl $FPGA init

trbcmd w $FPGA 0xa010 $Samples    		#Buffer depth
trbcmd w $FPGA 0xa011 $SamplesAfterTrigger      #Samples after trigger
trbcmd w $FPGA 0xa012 1           		#Process blocks
trbcmd w $FPGA 0xa013 $Threshold_Ch9   	#Trigger offset, invert
trbcmd w $FPGA 0xa014 0           #Readout offset
trbcmd w $FPGA 0xa015 1           #Downsampling
trbcmd w $FPGA 0xa016 8           #Baseline
#trbcmd w $FPGA 0xa017 0x30000000  #Trigger Enable ch31-00
#trbcmd w $FPGA 0xa018 0x0000      #Trigger Enable ch47-32
trbcmd w $FPGA 0xa017 0x30000      #Trigger Enable ch31-00   JM: Hardware channels 16 and 17
trbcmd w $FPGA 0xa018 0x0	   #Trigger Enable ch47-32
trbcmd w $FPGA 0xa01a 0x00000000  #Channel disable ch31-00, all channels except ch0
trbcmd w $FPGA 0xa01b 0x0000      #Channel disable ch47-32
trbcmd w $FPGA 0xa01c 0           #Processing mode 0=BlockMode, 1=PSA, 2=CFD
# ignore CFD stuff
#trbcmd w $FPGA 0xa01d 0x340       #CFD delay is 3, CFD window 64=0x40

trbcmd w $FPGA 0xa020 1           #Sum values
trbcmd w $FPGA 0xa021 1           #Sum values
trbcmd w $FPGA 0xa022 1           #Sum values
trbcmd w $FPGA 0xa023 1           #Sum values
trbcmd w $FPGA 0xa024 $Samples    #word count
trbcmd w $FPGA 0xa025 0           #word count
trbcmd w $FPGA 0xa026 0           #word count
trbcmd w $FPGA 0xa027 0           #word count

trbcmd w $FPGA 0xa000 0x100       #Reset Baseline

# Second ADC
FPGA1="0xC311"
~/trbsoft/daqtools/tools/adc.pl $FPGA1 init

trbcmd w $FPGA1 0xa010 $Samples    		#Buffer depth
trbcmd w $FPGA1 0xa011 $SamplesAfterTrigger      #Samples after trigger
trbcmd w $FPGA1 0xa012 1           		#Process blocks
trbcmd w $FPGA1 0xa013 $Threshold_Ch100        	#Trigger offset, invert
trbcmd w $FPGA1 0xa014 0           #Readout offset
trbcmd w $FPGA1 0xa015 1           #Downsampling
trbcmd w $FPGA1 0xa016 8           #Baseline
#trbcmd w $FPGA1 0xa017 0x30000000  #Trigger Enable ch31-00
#trbcmd w $FPGA1 0xa018 0x0000      #Trigger Enable ch47-32
trbcmd w $FPGA1 0xa017 0x30000      #Trigger Enable ch31-00  JM: Hardware channels 64 and 65
trbcmd w $FPGA1 0xa018 0x0          #Trigger Enable ch47-32
trbcmd w $FPGA1 0xa01a 0x00000000  #Channel disable ch31-00, all channels except ch0
trbcmd w $FPGA1 0xa01b 0x0000      #Channel disable ch47-32
trbcmd w $FPGA1 0xa01c 0           #Processing mode 0=BlockMode, 1=PSA, 2=CFD
# ignore CFD stuff
#trbcmd w $FPGA 0xa01d 0x340       #CFD delay is 3, CFD window 64=0x40

trbcmd w $FPGA1 0xa020 1           #Sum values
trbcmd w $FPGA1 0xa021 1           #Sum values
trbcmd w $FPGA1 0xa022 1           #Sum values
trbcmd w $FPGA1 0xa023 1           #Sum values
trbcmd w $FPGA1 0xa024 $Samples    #word count
trbcmd w $FPGA1 0xa025 0           #word count
trbcmd w $FPGA1 0xa026 0           #word count
trbcmd w $FPGA1 0xa027 0           #word count

trbcmd w $FPGA1 0xa000 0x100       #Reset Baseline
# Second ADC Done


#CTS_GUI
pkill -f "perl $HOME/trbsoft/daqtools/web/cts_gui"
cd $HOME/trbsoft/daqtools/web/
$HOME/trbsoft/daqtools/web/cts_gui &
#xterm -display :1 -hold -geometry 105x60 +sb -e '$HOME/trbsoft/daqtools/web/cts_gui --noopenxterm'

cd - #JM: to return to the directory in which the previous command was executed
#Load CTS configuration
sh ./cts-dump.sh


