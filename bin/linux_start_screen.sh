#!/bin/bash -x
#
# linux_start_screen.sh k x,y,width,height command
# k is a KEY to bind
# x,y and from top left, find resolution
#   xrandr | grep '*'
# command is to execute, if no command, than it will cd to default project
# defined here
# linux_start_screen.sh k 0,0,800,600 pwd
KEY=${1:-k}
source ~/config/bashrc/get_current_viewport.sh
class=vp_$(get_current_viewport)_class_$KEY
X_Y_WIDTH_HEIGHT=${2:-0,0,800,600}
COMMAND=$3
echo start_screen KEY=$KEY X_Y_WIDTH_HEIGHT=$X_Y_WIDTH_HEIGHT COMMAND=$COMMAND
SESSION_NAME="start_screen_$(uuidgen)"
screen -S $SESSION_NAME -d -m
if [[ -z "$COMMAND" ]]; then
  screen -S $SESSION_NAME -X screen -t gofordesi bash -c 'cd ~/gofordesi/gofordesi-webapp && exec bash'
else
  screen -S $SESSION_NAME -X screen bash -c "$COMMAND"
fi
xprop -f WM_CLASS 8s -set WM_CLASS $class -id $(xdotool getwindowfocus)
wmctrl -r :ACTIVE: -e 0,$X_Y_WIDTH_HEIGHT
screen -r $SESSION_NAME
# uncomment if you want to stay in this shell to see debug commands
# bash -l
