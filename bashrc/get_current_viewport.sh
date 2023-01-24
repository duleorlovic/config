#!/bin/bash
# http://askubuntu.com/questions/41093/is-there-a-command-to-go-a-specific-workspace
# http://stackoverflow.com/questions/17336915/return-value-in-bash-script
# https://forum.kde.org/viewtopic.php?f=66&t=151292#p395524
# use with vp_number=$(get_current_viewport)
get_current_viewport()
{
  # sudo vi /etc/gdm3/custom.conf

  if [[ -n $WAYLAND_DISPLAY ]]; then
    echo 0
  else
    wmctrl -d | awk '{print $1, $2}'| grep '*' | cut -d' ' -f1
  fi
}
