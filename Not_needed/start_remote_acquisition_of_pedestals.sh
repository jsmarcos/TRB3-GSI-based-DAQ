#!/bin/bash

ssh odroid@10.0.0.1 'DISPLAY=:0 nohup /home/odroid/trbsoft/userscripts/trb49/start_acquisition_of_pedestals.sh 45'
