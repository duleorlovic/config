#!/bin/bash
#
# This is used as helper function for window_shortcuts
# http://blog.trk.in.rs/2016/02/01/bash/#tocAnchor-1-3
# put the following line to Settings -> Keyboard -> Custom Shortcuts -> Command
# /home/orlovic/config/bashrc/activate_window.sh k
#
# limitations:
# it is run as same user (check with `notify-send $USER`)
# but it uses some interpretation so file needs to be with full path
# and this file needs to be executable: chmod +x activate_window.sh
if [ "$1" == "" ]; then
  echo Please provide key name, for example
  echo source activate_window.sh k
else
  source ~/config/bashrc/window_shortcuts.sh
  xdotool search --classname vp_$(get_current_viewport)_class_$1 windowactivate
fi
