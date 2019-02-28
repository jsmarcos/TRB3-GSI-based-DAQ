#!/bin/bash

#xterm -hold -e df &
    #/home/odroid/trb3/dabc/dabclogin
#xterm -hold -e /home/odroid/trbsoft/userscripts/trb49/startup_TRB49_test.sh &

xterm -e /home/odroid/trbsoft/userscripts/trb49/startup_TRB49_remotely.sh ; 
export DAQOPSERVER="localhost:1" ;
xterm -e /home/odroid/trbsoft/userscripts/trb49/launch_cts.sh  & # ';" means that the commands are executed in sequence. The next will only start when the previous finishes, JM.

#Load CTS configuration
cd /home/odroid/trbsoft/userscripts/trb49/
sh ./cts-dump-remotely.sh


#chromium-browser http://localhost:1234/cts/cts.htm http://localhost:1234/addons/adc.pl?BufferConfig

# Set initial trigger threshold (CTS channel 9 and channel 10)
#change_CTS_thresholds.sh 80 160

# Winner command set, so far. JM
#xterm -e /home/odroid/trbsoft/userscripts/trb49/startup_TRB49_test.sh ; /home/odroid/trbsoft/userscripts/trb49/launch_cts.sh & # ';" means that the commands are executed in sequence. The next will only start when the previous finishes, JM.




## /home/odroid/trbsoft/userscripts/trb49/launch_cts.sh &
#xterm -hold locale & 
#xterm -hold -e /home/odroid/trbsoft/userscripts/trb49/launch_cts.sh

#mate-terminal -e /home/odroid/trbsoft/userscripts/trb49/startup_TRB49.sh
#mate-terminal /
#cd /home/odroid/trbsoft/userscripts/trb49 /
#./startup_TRB49.sh
#/home/odroid/trbsoft/userscripts/trb49/startup_TRB49.sh
