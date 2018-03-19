#!/bin/bash
#
# this is use for Ctrl+j Keybord shortcut
# Settings -> Keyboard -> Custom Shortcuts -> Command
# /home/orlovic/config/bashrc/ctrl_j_browser.sh
#
# script limitation:
# it is run as same user (check with `notify-send $USER`)
# but it uses some interpretation so file needs to be with full path
# this file needs to be executable: chmod +x activate_window.sh
# can not use redirection in above Keyboard command, but you can save output to
# a file, just uncomment following lines
# exec >> /home/orlovic/config/bashrc/ctrl_j_browser.log
# exec 2>&1

echo start `date`
w_id=`xdotool getwindowfocus`
w_name=`xdotool getactivewindow getwindowname`
echo $w_id $w_name
if [[ $w_name = *"Firefox"* ]] || [[ $w_name = *"Chrom"* ]]; then
  xdotool key Return
  echo sending Return
else
  # since we send the same key we need to disable current keybindings
  # gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings
  # gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom14/ binding "'<Primary>i'"
  # but that returns a list customerXY but I need to check which is correct
  # sudo apt-get install dconf-editor
  # dconf read /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom13/binding
  # note that we need single quote inside string
  for i in {0..25}; do
    if [[ "'<Primary>j'" = "$(dconf read /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$i/binding)" ]]; then
      echo found Ctrl+j binding on $i
      # dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$i/binding "'<Primary>i'"
      # somehow this binding is not yet flushed when we use dconf, so use gsettings
      gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$i/ binding "'<Primary>i'"
      xdotool key ctrl+j
      dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$i/binding "'<Primary>j'"
      echo sending ctrl+j
    fi
  done
fi
