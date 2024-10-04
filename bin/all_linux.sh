#!/bin/bash -x

# On two monitor setup
# xrandr | grep '*'
#   1280x1024     59.89*+
#   1920x1080     59.96*+
#
#     1920x1080p                1280px1024x
#   -   1120  |-800-|     -   680   |-600-|
#            640    |              624    |
#   ----------------|     -400(-400-|-----|
#   440      440    |      280(    400    |
#   ----------------|     ----(-----|-----|
DELAY_BETWEEN_TERMINALS=0.3
konsole -e ~/config/bin/linux_start_screen.sh k 1120,0,800,640 &
sleep $DELAY_BETWEEN_TERMINALS
konsole -e ~/config/bin/linux_start_screen.sh comma 0,640,1920,440 &
sleep $DELAY_BETWEEN_TERMINALS

# x is + 1920
konsole -e ~/config/bin/linux_start_screen.sh colon $((1920+680)),0,600,624 &
sleep $DELAY_BETWEEN_TERMINALS
konsole -e ~/config/bin/linux_start_screen.sh slash $((1920+680)),624,600,400 &
sleep $DELAY_BETWEEN_TERMINALS
konsole -e ~/config/bin/linux_start_screen.sh l 1920,624,600,400 "cd jekyll/blog && vi" &
sleep $DELAY_BETWEEN_TERMINALS
konsole -e ~/config/bin/linux_start_screen.sh dot $((1920+80)),624,600,400 &
