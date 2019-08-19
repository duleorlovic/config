# https://stackoverflow.com/questions/49857332/bash-exit-from-source-d-script
# find out how the script was invoked
# we don't want to end the user's terminal session!
if [[ "$0" != "$BASH_SOURCE" ]] ; then
  # this script is executed via `source`!
  # An `exit` will close the user's console!
  EXIT_OR_RETURN=return
else
  # this script is not `source`-d, it's safe to exit via `exit`
  EXIT_OR_RETURN=exit
fi

export EXIT_OR_RETURN

# you can use like
# $EXIT_OR_RETURN 1
