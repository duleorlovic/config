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
# exec >> /home/orlovic/config/temp_backup/ctrl_j_browser.log
# exec 2>&1

# to enable emacs keybin on chrome and firefox input text (ctrl+h/d, ctrl+a/e,
# ctrl+b/f, ctrl+w) you can enable gtk key theme using editors
# sudo apt-get install dconf-editor # this is for gtk3
# for old gtk2 there is: gconf-editor
# gsettings set org.gnome.desktop.interface gtk-key-theme "Emacs"
# or for old gtk2
# gconftool-2 --type=string --set /desktop/gnome/interface/gtk_key_theme Emacs

# to enable ctrl+j we can use keyboard custom shortcuts
# since we send the same key on terminal we need to disable current keybindings
# gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings
# gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom14/ binding "'<Primary>i'"
# but that returns a list customerXY but I need to check which is correct for
# our mappings
# dconf read /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom13/binding
# note that we need single quote inside string

find_property_name() {
  for i in {0..25}; do
    if [[ "'<Primary>j'" = "$(dconf read /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$i/binding)" ]]; then
      echo found Ctrl+j binding on $i
      break
    fi
  done
  if [[ "$i" -eq "25" ]]; then
    echo "can not find Ctrl+j binding. Please assign in Settings -> Keyboard \
    -> Custom shortcuts"
  fi
}
echo start `date`
w_id=`xdotool getwindowfocus`
w_name=`xdotool getactivewindow getwindowname`
i=14
echo $w_id $w_name
if [[ $w_name = *"Firefox"* ]] || [[ $w_name = *"Chrom"* ]]; then
  xdotool key Return
  echo sending Return
else
  # dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$i/binding "'<Primary>i'"
  # somehow this binding is not yet flushed when we use dconf, so use gsettings
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$i/ binding "'<Primary>i'"
  sleep 0.3
  xdotool key ctrl+j
  # dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$i/binding "'<Primary>j'"
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$i/ binding "'<Primary>j'"
  echo sending ctrl+j
fi
