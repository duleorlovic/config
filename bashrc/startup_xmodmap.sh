#!/bin/bash
#
# call this file from startup applications and see in tail -f /var/log/syslog
# /home/orlovic/config/bashrc/startup_xmodmap.sh 2>&1 | /usr/bin/logger
echo start startup_xmodmap
[[ -f /home/orlovic/.Xmodmap ]] && sleep 20 && xmodmap /home/orlovic/.Xmodmap
echo end startup_xmodmap $?
