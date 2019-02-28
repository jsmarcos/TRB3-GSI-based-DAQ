#
# set addresses

#./configure_trb3.sh # central hub configuration to send data via GbE

trbcmd w 0xfffe 0xc5 0x50ff     ### A line added as request for JAN

# setup tdcs on TRB3
#trbcmd w 0xfe48 0xc0 0x00000001 ## logic analyser control register
#trbcmd w 0xfe48 0xc1 0x000f0005 ## trigger window enable & trigger window width
#trbcmd w 0xfe48 0xc2 0x0000000f ## channel 01-31 enable
#trbcmd w 0xfe48 0xc3 0x00000000 ## channel 32-63 enable

# setup tdc on TRB3 for designs after 20130320
trbcmd w 0xfe48 0xc800 0x00000001 ## logic analyser control register
trbcmd w 0xfe48 0xc801 0x000f0005 ## trigger window enable & trigger window width
trbcmd w 0xfe48 0xc802 0x0000000f ## channel 01-31 enable
trbcmd w 0xfe48 0xc803 0x00000000 ## channel 32-63 enable
trbcmd w 0xfe48 0xc804 0x00000080 ## data transfer limit

trbcmd w 0x8000 0xa137 0xfffff # set pulser #1 in CTS to 95Hz

