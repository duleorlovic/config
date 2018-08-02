#!/bin/bash
#
# this file should be run on ubuntu Startup Applications
# with a command that redirects output to /var/log/syslog
# /home/orlovic/config/bashrc/startup_ctrl_on_window_focus.sh 2>&1 | /usr/bin/logger
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

# to enable ctrl+j on browser windows we use keyboard custom shortcuts
# since we send the same key on terminal we need to disable that shortcut
# keybindings so it works much faster ie we will map to shift+ctrl+j instead of
# ctrl+j. it is better to disable on window focus than on each key stroke
# there are two commands: gsettings and dconf
# gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings
# gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom14/ binding "'<Primary>j'"
# but that returns a list customerXY and I need to check which is correct for
# our mappings
# dconf read /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom13/binding
# note that we need single quote inside string

ctrl_j_number=unknown
alt_v_number=unknown
find_property_name() {
  for i in {0..50}; do
    read_i=$(dconf read /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$i/binding)
    if [ "'<Primary>j'" = "$read_i" ] || [ "'<Shift><Primary>j'" = "$read_i" ] ; then
      echo found Ctrl+j binding on $i
      ctrl_j_number=$i
      break
    fi
  done
  if [[ "$i" -eq "50" ]]; then
    message="can not find Ctrl+j or Shift+Ctrl+j binding. Please assign in Settings -> Keyboard \
    -> Custom shortcuts"
    echo $message
    # notify does not work so comment out
    # notify-send $message
    exit
  fi
  for i in {0..50}; do
    read_i=$(dconf read /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$i/binding)
    if [ "'<Alt>v'" = "$read_i" ] || [ "'<Shift><Alt>v'" = "$read_i" ] ; then
      echo found Alt+v binding on $i
      alt_v_number=$i
      break
    fi
  done
  if [[ "$i" -eq "50" ]]; then
    message="can not find Alt+v or Shoft+Alt+v binding. Please assign in Settings -> Keyboard \
    -> Custom shortcuts"
    echo $message
    # notify does not work so comment out
    # notify-send $message
    exit
  fi
}

disable_keymap() {
  # dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$i/binding "'<Shift><Primary>j'"
  # somehow this binding is not yet flushed when we use dconf, so use gsettings
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$ctrl_j_number/ binding "'<Shift><Primary>j'"
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$alt_v_number/ binding "'<Shift><Alt>v'"
}
enable_keymap() {
  # dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$i/binding "'<Primary>j'"
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$ctrl_j_number/ binding "'<Primary>j'"
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$alt_v_number/ binding "'<Alt>v'"
}

find_property_name
echo start ctrl_on_window_focus ctrl_j_number=$ctrl_j_number alt_v_number=$alt_v_number
w_name=start_name
last_status=enabled
enable_keymap
while true
do
  new_w_name=`xdotool getactivewindow getwindowname`
  if [ "$new_w_name" != "$w_name" ]; then
    w_name=$new_w_name
    # echo $w_name
    if [[ $w_name =~ Firefox|Chrom|Viber|'Developer Tools'|'Unlock Login Keyring'|'Authentication Required'|'Authenticate' ]] ; then
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
