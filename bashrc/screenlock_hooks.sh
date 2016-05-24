#!/bin/bash
#
# This is a script that runs commands on screen lock/unlock
# for camera, wind you authorization key in Chrome dev tools, request headers
# export CAMERA_AUTHORIZATION=123123 in config/keys/my_keys.sh
# don't forget chmod +x /home/orlovic/config/bashrc/screen_lock_hooks.sh
# if [ "`pgrep dbus-monitor`" == "" ];then
#   echo Starting screenlock_hooks
#   /home/orlovic/config/bashrc/screenlock_hooks.sh
# fi
# stop script with: pkill screenlock # not with dbus-monitor

#CAMERA_IP=192.168.0.3
CAMERA_IP=192.168.0.2:8002
SCREEN_LOCKED="echo 'Screen locked'"
SCREEN_UNLOCKED="echo 'Screen unlocked'"
STOP_CAMERA_DETECTION="curl 'http://$CAMERA_IP/form/enet?enet_source=md.asp&enet_avs_md_enable=No' -H 'Authorization: Basic $CAMERA_AUTHORIZATION'"
START_CAMERA_DETECTION="curl 'http://$CAMERA_IP/form/enet?enet_source=md.asp&enet_avs_md_enable=Yes' -H 'Authorization: Basic $CAMERA_AUTHORIZATION'"
# http://unix.stackexchange.com/questions/28181/run-script-on-screen-lock-unlock
echo Start monitoring locked screen
dbus-monitor --session "type='signal',interface='com.ubuntu.Upstart0_6'" | \
(
  while true; do
    read X
    if echo $X | grep "desktop-lock" &> /dev/null; then
      eval $SCREEN_LOCKED
      date
      eval $START_CAMERA_DETECTION
    elif echo $X | grep "desktop-unlock" &> /dev/null; then
      eval $SCREEN_UNLOCKED
      date
      eval $STOP_CAMERA_DETECTION
    fi
  done
) 2>&1 > /tmp/screenlock_hooks &
