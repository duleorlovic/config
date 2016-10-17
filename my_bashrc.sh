MY_FILES=(
  ~/config/keys/my_keys.sh
  ~/config/bashrc/window_shortcuts.sh
  ~/config/bashrc/ionic.sh
)

for my_file in ${MY_FILES[*]}; do
  if [ -f $my_file ]; then
    source $my_file
  fi
done

if [ "`pgrep dbus-monitor`" == "" ];then
  echo Starting monitor_lock_hooks
  /home/orlovic/config/bashrc/monitor_lock_hooks.sh
fi

export EDITOR=vim

# Add Android SDK tools to PATH
export ANDROID_HOME=/home/orlovic/Android/Sdk/
# for android
export PATH="$PATH:$HOME/Android/Sdk/tools"
# for adb
export PATH="$PATH:$HOME/Android/Sdk/platform-tools"
# for genymotion
export PATH="$PATH:$HOME/Programs/genymotion"
# for studio.sh
export PATH="$PATH:$HOME/Programs/android-studio/bin"

export SECRET_KEY_BASE=123asd

function d {
  if [  -z $1 ]
  then
    echo Default is middle value: d 0.5
  fi
  # to find your crtc number use xrandr --verbose
  xrandr --output ${CRTC:DFP1} --brightness ${1:-0.5}
  # when error is xrandr: Need crtc to set gamma on.
  # sudo apt-get install xbackligh
  # xbacklight -dec 2 # or -inc %
}
alias dim=d

last_migration(){
  vim db/migrate/$(ls db/migrate/ | sort | tail -1)
}

# copy line to clipboard
bind '"\C-l": "\C-e\C-u xsel --clipboard <<"EOF"\n\C-y\nEOF\n\C-y"'

function echo_red {
  tput setaf 1
  echo $@
  tput sgr0
}

function echo_and_run {
  echo_red $@
  $@
}
