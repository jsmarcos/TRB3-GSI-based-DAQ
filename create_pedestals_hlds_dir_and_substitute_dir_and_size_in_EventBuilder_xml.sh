#!/bin/bash

DIR_HLDS_NEW=$1
SIZE_HLDS_NEW=$2
#ACQUISITION_TIME_NEW=$3

DIR_EventBuilder_xml="/home/daq/DAQ_Software/TRB_DAQ_using_DABC"

# Create the directory DIR_HLDS_NEW:
mkdir -p $DIR_HLDS_NEW

# Replace the path of the HLDs files (passed as the 1st argument) and the size of the HLDs files (2nd argument)
sed -e "s|SIZE_HLD|$SIZE_HLDS_NEW|g" -e "s|DIR_HLDS|$DIR_HLDS_NEW|g" "$DIR_EventBuilder_xml/EventBuilder_TRB49_base.xml" > "$DIR_EventBuilder_xml/EventBuilder_TRB49.xml"

# Replace the acquisition time in the script that sends a ssh command to esecute other script in the remote controller of TRB (Odroid-C2 mini-PC)
#sed -e "s|ACQUISITION_TIME|$ACQUISITION_TIME_NEW|g" "$DIR_EventBuilder_xml/start_remote_acquisition_of_pedestals_base.sh" > "$DIR_EventBuilder_xml/start_remote_acquisition_of_pedestals.sh"




