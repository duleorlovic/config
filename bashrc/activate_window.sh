#!/bin/bash
#
# This is used as helper function for window_shortcuts
# http://blog.trk.in.rs/2016/02/01/bash/#tocAnchor-1-3
# put the following line to Settings -> Keyboard -> Custom Shortcuts -> Command
# /home/orlovic/config/bashrc/activate_window.sh k
#
# script limitation:
# it is run as same user (check with `notify-send $USER`)
# but it uses some interpretation so file needs to be with full path
# this file needs to be executable: chmod +x activate_window.sh
# can not use redirection in above Keyboard command, but you can save output to
# a file, just uncomment following lines
# exec >> /home/orlovic/config/bashrc/activate_window.log
# exec 2>&1
if [ "$1" == "" ]; then
  echo Please provide key name, for example
  echo source activate_window.sh k
else
  if [ "$WAYLAND_DISPLAY" == "" ]; then
    # Xorg
    source ~/config/bashrc/get_current_viewport.sh
    xdotool search --classname vp_$(get_current_viewport)_class_$1 windowactivate
  else
    # https://github.com/rvaiya/keyd#sample-config
    # git clone git@github.com:lucaswerkmeister/activate-window-by-title.git ~/.local/share/gnome-shell/extensions/
    gdbus call --session \
    --dest org.gnome.Shell \
    --object-path /de/lucaswerkmeister/ActivateWindowByTitle \
    --method de.lucaswerkmeister.ActivateWindowByTitle.activateByWmClass \
    'gedit'
  fi
fi
