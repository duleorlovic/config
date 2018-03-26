#!/bin/bash
# exec >> /home/orlovic/Downloads/output.log
# exec 2>&1

# release all modifiers
# https://unix.stackexchange.com/questions/60007/how-to-force-release-of-a-keyboard-modifiers
xdotool keyup Shift_L Shift_R Control_L Control_R Meta_L Meta_R Alt_L Alt_R Super_L Super_R Hyper_L Hyper_R ISO_Level2_Latch ISO_Level3_Shift ISO_Level3_Latch ISO_Level3_Lock ISO_Level5_Shift ISO_Level5_Latch ISO_Level5_Lock
xdotool key Ctrl+r
xdotool keydown Alt_L
