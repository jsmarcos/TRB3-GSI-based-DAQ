#!/bin/bash

#FPGA1="0xC310"
#FPGA2="0xC311"

ssh odroid@10.0.0.1 'DISPLAY=:0 nohup /home/odroid/trbsoft/userscripts/trb49/change_CTS_thresholds.sh 80 160'