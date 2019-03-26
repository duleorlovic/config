#!/bin/bash
# http://askubuntu.com/questions/41093/is-there-a-command-to-go-a-specific-workspace
# http://stackoverflow.com/questions/17336915/return-value-in-bash-script
# use with vp_number=$(get_current_viewport)
get_current_viewport()
{
  SIZE=`wmctrl -d | awk '{print $6}'`
  # http://stackoverflow.com/questions/23663963/split-string-into-multiple-variables-in-bash
  IFS=',' read vp_width vp_height <<< $SIZE
  if [ "$vp_width" = "0" ] && [ "$vp_height" = "0" ]; then
    echo 1
  else
    if [ "$vp_height" = "0" ]; then
      echo 2
    else
      if [ "$vp_width" = "0" ]; then
        echo 3
      else
        echo 4
      fi
    fi
  fi
}
