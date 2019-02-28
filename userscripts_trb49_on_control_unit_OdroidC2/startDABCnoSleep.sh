#!/bin/bash
#used by main.py
. ~/trb3/dabc/dabclogin
#xterm -display :1 -hold -geometry 115x17 -fg white -bg Black -e 'dabc_exe /home/odroid/trbsoft/userscripts/trb49/EventBuilder_TRB49.xml'
xterm -hold -e 'dabc_exe /home/odroid/trbsoft/userscripts/trb49/EventBuilder_TRB49.xml'

