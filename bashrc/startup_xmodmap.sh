#!/bin/bash
#
# call this file from startup applications and see in tail -f /var/log/syslog
# /home/orlovic/config/bashrc/startup_xmodmap.sh 2>&1 | /usr/bin/logger
# also put in after resume suspend script ~/config/bashrc/startup_after_sleep.sh
echo start startup_xmodmap
[[ -f /home/orlovic/.Xmodmap ]] && sleep 10 && xmodmap /home/orlovic/.Xmodmap
echo end startup_xmodmap $?
