#!/bin/bash

ssh odroid@10.0.0.1 'DISPLAY=:0 nohup /home/odroid/trbsoft/userscripts/trb49/start_acquisition.sh 15 80 161'
