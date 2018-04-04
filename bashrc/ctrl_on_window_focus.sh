#!/bin/bash
#
# this file should be run on ubuntu Startup Applications
# with a command that redirects output to /var/log/syslog
# /home/orlovic/config/bashrc/ctrl_on_window_focus.sh 2>&1 | /usr/bin/logger -t ctrl_on_window_focus
# to see logs run tail, but sometimes messages are grouped so wait
# tail -f /var/log/syslog
#
# to enable emacs keybin on chrome and firefox input text (ctrl+h/d, ctrl+a/e,
# ctrl+b/f, ctrl+w) you can enable gtk key theme using editors
# sudo apt-get install dconf-editor # this is for gtk3
# for old gtk2 there is: gconf-editor
# gsettings set org.gnome.desktop.interface gtk-key-theme "Emacs"
# or for old gtk2
# gconftool-2 --type=string --set /desktop/gnome/interface/gtk_key_theme Emacs

# to enable ctrl+j on browser windows we can use keyboard custom shortcuts
# since we send the same key on terminal we need to disable current keybindings
# ie we will map to ctrl+y instead of ctrl+j
# it is better to disable on window focus than on each key stroke
# there are two commands: gsettings and dconf
# gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings
# gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom14/ binding "'<Primary>y'"
# but that returns a list customerXY but I need to check which is correct for
# our mappings
# dconf read /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom13/binding
# note that we need single quote inside string

custom_number=unknown
find_property_name() {
  for i in {0..25}; do
    read_i=$(dconf read /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$i/binding)
    if [ "'<Primary>j'" = "$read_i" ] || [ "'<Primary>y'" = "$read_i" ] ; then
      echo found Ctrl+j binding on $i
      custom_number=$i
      break
    fi
  done
  if [[ "$i" -eq "25" ]]; then
    message="can not find Ctrl+j or Ctrl+y binding. Please assign in Settings -> Keyboard \
    -> Custom shortcuts"
    echo $message
    # notify does not work so comment out
    # notify-send $message
    exit
  fi
}

disable_keymap() {
  # dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$i/binding "'<Primary>y'"
  # somehow this binding is not yet flushed when we use dconf, so use gsettings
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$custom_number/ binding "'<Primary>y'"
}
enable_keymap() {
  # dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$i/binding "'<Primary>j'"
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$custom_number/ binding "'<Primary>j'"
}

find_property_name
echo start ctrl_on_window_focus custom_number=$custom_number
w_name=start_name
last_status=enabled
enable_keymap
while true
do
  new_w_name=`xdotool getactivewindow getwindowname`
  if [ "$new_w_name" != "$w_name" ]; then
    w_name=$new_w_name
    # echo $w_name
    if [[ $w_name =~ Firefox|Chrom|Viber|'Developer Tools' ]] ; then
      echo "'$w_name' is firefox or chrome"
      if [ "$last_status" = "disabled" ]; then
        last_status=enabled
        enable_keymap
        echo enable keymap
      fi
    else
      echo "'$w_name' is NOT firefox or chrome"
      if [ "$last_status" != "disabled" ]; then
        last_status=disabled
        disable_keymap
        echo disable keymap
      fi
    fi
  fi
  sleep 0.3
done
