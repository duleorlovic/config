#!/bin/bash
#
# this is use for Ctrl+j Keybord shortcut
# Settings -> Keyboard -> Custom Shortcuts -> Command
# /home/orlovic/config/bashrc/ctrl_j_browser.sh >> /home/orlovic/config/bashrc/ctrl_j_browser.log 2>&1
#
# script limitation:
# it is run as same user (check with `notify-send $USER`)
# but it uses some interpretation so file needs to be with full path
# this file needs to be executable: chmod +x activate_window.sh
# can not use redirection in above Keyboard command, but you can save output to
# a file, just uncomment following lines
# exec >> /home/orlovic/config/bashrc/activate_window.log
# exec 2>&1
# exec >> /home/orlovic/config/bashrc/ctrl_j_browser.log
# exec 2>&1
echo start
w_id=`xdotool getwindowfocus`
w_name=`xdotool getactivewindow getwindowname`
echo $w_id $w_name
if [[ $w_name = *"Firefox"* ]] || [[ $w_name = *"Chrom"* ]]; then
  xdotool key Return
  echo sending Return
else
  xdotool key ctrl+j
  echo sending ctrl+j
fi
