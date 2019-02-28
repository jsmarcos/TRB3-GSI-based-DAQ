#!/bin/bash

DIR_HLDS_NEW=$1
SIZE_HLDS_NEW=$2
#ACQUISITION_TIME_NEW=$3

#THRESHOLD_CH9_NEW=$4
#THRESHOLD_CH10_NEW=$5

DIR_EventBuilder_xml="/home/daq/DAQ_Software/TRB_DAQ_using_DABC"
DIR_remote_change_thr_script="/home/daq/DAQ_Software/TRB_DAQ_using_DABC"

# Create the directory DIR_HLDS_NEW:
mkdir -p $DIR_HLDS_NEW

# Replace the path of the HLDs files (passed as the 1st argument) and the size of the HLDs files (2nd argument)
sed -e "s|SIZE_HLD|$SIZE_HLDS_NEW|g" -e "s|DIR_HLDS|$DIR_HLDS_NEW|g" "$DIR_EventBuilder_xml/EventBuilder_TRB49_base.xml" > "$DIR_EventBuilder_xml/EventBuilder_TRB49.xml"

# Replace the acquisition time and the CTS trigger thresholds (Ch9 and Ch10) in the script that sends a ssh command to execute other script in the remote controller of TRB (Odroid-C2 mini-PC)
#sed -e "s|ACQUISITION_TIME|$ACQUISITION_TIME_NEW|g" -e "s|THRESHOLD_CH9|$THRESHOLD_CH9_NEW|g" -e "s|THRESHOLD_CH10|$THRESHOLD_CH10_NEW|g" "$DIR_EventBuilder_xml/start_remote_acquisition_base.sh" > "$DIR_EventBuilder_xml/start_remote_acquisition.sh"

# Replace the CTS trigger thresholds (Ch9 and Ch10) in the scipt that send ssh command to execute 'start_non_stop_acquisition.sh' in Odroid
#sed -e "s|THRESHOLD_CH9|$THRESHOLD_CH9_NEW|g" -e "s|THRESHOLD_CH10|$THRESHOLD_CH10_NEW|g" "$DIR_EventBuilder_xml/start_remote_non_stop_acquisition_base.sh" > "$DIR_EventBuilder_xml/start_remote_non_stop_acquisition.sh"

