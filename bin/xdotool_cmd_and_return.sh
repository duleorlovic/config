#/bin/bash
# set -x # show command being executed
#
# This is used with vim Dispatch so we can type a command in another window and
# return to current window.
# Typing is done in separate script so we return immediatelly

# DO NOT TEST WITH CTR+J, use Enter instead (CTRL closes the target_window)

if [ "$1" == "" ]; then
  cat <<HERE_DOC
  Please provide a command, for examle:
     xdotool_cmd_and_return.sh "date"
HERE_DOC
  exit 1
fi

if [ "$2" != "" ]; then
  cat <<HERE_DOC
  Please wrap command inside brackets
     xdotool_cmd_and_return.sh "rspec spec"
HERE_DOC
  exit 1
fi
cmd=$1
current_window=`xdotool getactivewindow | tr -d "\n"`
target_window=`source ~/config/bashrc/get_current_viewport.sh && xdotool search --classname vp_$(get_current_viewport)_class_slash | tr -d "\n"`
echo current_window=$current_window target_window=$target_window cmd=$cmd

# this is slower since we type cmd
xdotool windowactivate --sync $target_window type --args 1 "$(printf "$cmd\n\e ")" windowactivate $current_window
exit 0

# but typing only /tmp/a is also slow since window needs to be active for
# xdotool type from /tmp/a to finish typing
# long string will introcude delay, so that means it is still blocking
# echo 'xdotool type "$(printf "'$cmd''$cmd''$cmd''$cmd''$cmd''$cmd'\n\e ")"' > /tmp/a
echo 'xdotool type --clearmodifiers "$(printf "'$cmd'\n\e ")"' > /tmp/a
chmod +x /tmp/a
# --clearmodifiers will clear only for command but it will activate when command
# finish, so it might acts that ctrl is still pressed
time xdotool windowactivate --sync $target_window type --clearmodifiers --args 1 "$(printf "/tmp/a\n\e ")" windowactivate $current_window
