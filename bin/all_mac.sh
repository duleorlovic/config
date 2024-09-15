#!/bin/bash -x
# dell 2560x1440
# lg 1920x1080
# LEFT,TOP, left,top of the RIGHT,BOTTOM angle
# mac_start_screen.sh k 800,100,1600,900
# osascript -e 'tell application "Terminal" to set bounds of front window to {1500,0,2560,900}'
DELAY_BETWEEN_TERMINALS=2
osascript -e 'tell application "Terminal" to do script "mac_start_screen.sh k 1500,0,2560,800"'
sleep $DELAY_BETWEEN_TERMINALS
osascript -e 'tell application "Terminal" to do script "mac_start_screen.sh comma 0,800,2560,1440"'
sleep $DELAY_BETWEEN_TERMINALS
osascript -e 'tell application "Terminal" to do script "mac_start_screen.sh l 3300,1000,3890,1440 \"cd ~/jekyll/blog && vi\""'
sleep $DELAY_BETWEEN_TERMINALS
osascript -e 'tell application "Terminal" to do script "mac_start_screen.sh dot 2560,1000,3300,1440"'
sleep $DELAY_BETWEEN_TERMINALS
osascript -e 'tell application "Terminal" to do script "mac_start_screen.sh colon 4000,0,5120,720"'
sleep $DELAY_BETWEEN_TERMINALS
osascript -e 'tell application "Terminal" to do script "mac_start_screen.sh slash 4000,720,5120,1440"'
sleep $DELAY_BETWEEN_TERMINALS
osascript -e 'tell application "Terminal" to do script "mac_start_screen.sh j -720,0,0,500"'
sleep $DELAY_BETWEEN_TERMINALS
osascript -e 'tell application "Terminal" to do script "mac_start_screen.sh h -820,50,-50,600"'
sleep $DELAY_BETWEEN_TERMINALS
osascript -e 'tell application "Terminal" to do script "mac_start_screen.sh m -1920,600,0,1080"'
