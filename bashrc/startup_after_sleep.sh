#!/bin/sh

# link this file to /lib/systemd/system-sleep/startup_after_sleep.sh
# sudo ln -s /home/orlovic/config/bashrc/startup_after_sleep.sh /lib/systemd/system-sleep/

case $1 in
  post)
    /home/orlovic/config/bashrc/startup_xmodmap.sh 2>&1 | /usr/bin/logger
    ;;
esac
