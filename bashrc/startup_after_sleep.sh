#!/bin/sh

#https://askubuntu.com/questions/458245/unable-to-get-xmodmap-working-after-suspend/502622 
# /etc/pm/sleep.d/ also does not work

# Variation to put in /lib/systemd/system-sleep does not work
# link this file to /lib/systemd/system-sleep/startup_after_sleep.sh
# sudo ln -s /home/orlovic/config/bashrc/startup_after_sleep.sh /lib/systemd/system-sleep/
# somehow if I put this in background than startup_xmodmap will be stopped
# at sleep, otherwise it will delay network manager

case $1 in
  post)
    echo "startup_after_sleep.sh post" | /usr/bin/logger
    # this does not work probably no X
    # notify-send $USER --urgency critical "startup_after_sleep.sh post calling startup_xmodmap"
    /home/orlovic/config/bashrc/startup_xmodmap.sh 2>&1 | /usr/bin/logger
    echo "startup_after_sleep.sh calling startup_xmodmad" | /usr/bin/logger
    ;;
esac
