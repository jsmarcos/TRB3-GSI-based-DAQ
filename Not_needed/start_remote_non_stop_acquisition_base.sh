#!/bin/bash

ssh odroid@10.0.0.1 'DISPLAY=:0 nohup /home/odroid/trbsoft/userscripts/trb49/start_non_stop_acquisition.sh THRESHOLD_CH9 THRESHOLD_CH10'
