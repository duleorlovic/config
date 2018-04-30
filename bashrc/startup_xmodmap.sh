#!/bin/bash
#
# call this file from startup applications and see in tail -f /var/log/syslog
# /home/orlovic/config/bashrc/startup_xmodmap.sh 2>&1 | /usr/bin/logger
# also put in after resume suspend script ~/config/bashrc/startup_after_sleep.sh
#
# note that in after system sleep it needs to connect to x server
# https://ubuntuforums.org/showthread.php?t=2380045
echo startup_xmodmap start
if [[ -f /home/orlovic/.Xmodmap ]]
then
  # this sleep is required
  sleep 5
  declare -x DISPLAY=":0.0"
  declare -x XAUTHORITY="/home/orlovic/.Xauthority"
  xmodmap /home/orlovic/.Xmodmap

  # also watch for keyboard changes and run xmodmap again if it is on EN
  if [[ -z "$(ps aux | grep -v grep | grep 'dconf watch /org/gnome/desktop/input-sources/current')" ]]
  then
    echo 'startup_xmodmap starting watching for keyboard change'
    dconf watch /org/gnome/desktop/input-sources/current | xargs -L 2 -I '{}' sh -c '
    input="{}"
    echo input=$input
    number="$(echo $input | cut -s -d" " -f2)"
    if [ -n "$number" ];then
      echo $number
      if [ -n "$number" ] && [ "$number" -eq 0 ]; then
        echo EN
        xmodmap /home/orlovic/.Xmodmap
      else
        echo nonEN
      fi
    fi
    ' &
  fi
fi
echo startup_xmodmap finish
