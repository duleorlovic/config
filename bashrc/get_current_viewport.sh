#!/bin/bash
# http://askubuntu.com/questions/41093/is-there-a-command-to-go-a-specific-workspace
# http://stackoverflow.com/questions/17336915/return-value-in-bash-script
# use with vp_number=$(get_current_viewport)
get_current_viewport()
{
  wmctrl -d | awk '{print $1, $2}'| grep '*' | cut -d' ' -f1
}
