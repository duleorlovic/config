#!/bin/bash
# uncommend following lines if you want to see echo log
# exec >> /home/orlovic/Downloads/output.log
# exec 2>&1
# echo ctrl_browser $1

# notify-send "Hey Duke, this is deprecated because you can use vimium to reload 'r', to close 'x' \
# and to open new tab 't'"
$EXIT_OR_RETURN 1
if [ "$1" = "" ]; then
  notify-send "Please provide a key, like Ctrl+r" -u critical
fi

# release all modifiers
# https://unix.stackexchange.com/questions/60007/how-to-force-release-of-a-keyboard-modifiers
xdotool keyup Shift_L Shift_R Control_L Control_R Meta_L Meta_R Alt_L Alt_R Super_L Super_R Hyper_L Hyper_R ISO_Level2_Latch ISO_Level3_Shift ISO_Level3_Latch ISO_Level3_Lock ISO_Level5_Shift ISO_Level5_Latch ISO_Level5_Lock
xdotool key $1
# keydown again so you can run multiple reloads while keeping alt key down
# problem is if you release alt to fast, you need to click again to release it
# xdotool keydown Alt_L
