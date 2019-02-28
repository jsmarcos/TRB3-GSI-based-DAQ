#!/bin/bash

THRESHOLD_CH9_NEW=$1
THRESHOLD_CH10_NEW=$2
TIME_ACQ_NEW=$3

DIR_config_file="/home/daq/DAQ_Software/TRB_DAQ_using_DABC"

#sed -e "s|THRESHOLD_CH9|$THRESHOLD_CH9_NEW|g" -e "s|THRESHOLD_CH10|$THRESHOLD_CH10_NEW|g" "$DIR_remote_change_thr_script/remote_change_CTS_trigger_thresholds_base.sh" > "$DIR_remote_change_thr_script/remote_change_CTS_trigger_thresholds.sh"

sed -i "s/THRS_CH9=.*/THRS_CH9=$THRESHOLD_CH9_NEW/" $DIR_config_file/config.conf &&   # With '&&', the next command will only be executed if, and only if the previous command returns an exit status of zero.
sed -i "s/THRS_CH10=.*/THRS_CH10=$THRESHOLD_CH10_NEW/" $DIR_config_file/config.conf &&
sed -i "s/TIME_ACQ=.*/TIME_ACQ=$TIME_ACQ_NEW/" $DIR_config_file/config.conf &&

scp $DIR_config_file/config.conf odroid@10.0.0.1:/home/odroid/trbsoft/userscripts/trb49

#sleep 3
