#!/bin/bash -x

# start_screen.sh j 800,100,1600,900
# start_screen.sh j 800,100,1600,900 pwd

KEY=${1:-k}
LEFT_TOP_RIGHT_BOTTOM=${2:-800,100,1600,900}
COMMAND=$3
echo start_screen KEY=$KEY LEFT_TOP_RIGHT_BOTTOM=$LEFT_TOP_RIGHT_BOTTOM
SESSION_NAME="start_screen_$(uuidgen)"
screen -S $SESSION_NAME -d -m
if [[ -z "$COMMAND" ]]; then
  screen -S $SESSION_NAME -X screen -t gofordesi bash -c 'cd ~/gofordesi/gofordesi-webapp && exec bash'
  screen -S $SESSION_NAME -X screen -t xceednet bash -c 'cd ~/xceednet && exec bash'
else
  screen -S $SESSION_NAME -X screen bash -c "$COMMAND"
fi
screen -S $SESSION_NAME -X screen osascript ~/config/bashrc/mac_scripts/mac_bind_window_to_key.scpt $KEY
screen -S $SESSION_NAME -X screen osascript -e "tell application \"Terminal\" to set bounds of front window to {$LEFT_TOP_RIGHT_BOTTOM}"
screen -r $SESSION_NAME
