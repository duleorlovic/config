MY_FILES=(
  ~/config/keys/my_keys.sh
  ~/config/bashrc/window_shortcuts.sh
  ~/config/bashrc/ionic.sh
  ~/config/bashrc/rails.sh
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
export ANDROID_HOME=/media/orlovic/bf12a7e5-a5d4-4532-8612-a3984f90b56c/shared/Android/Sdk
# issue with unable to load driver https://stackoverflow.com/questions/35911302/cannot-launch-emulator-on-linux-ubuntu-15-10/36625175#36625175
export ANDROID_EMULATOR_USE_SYSTEM_LIBS=1
# for android command
export PATH="$PATH:$ANDROID_HOME/tools"
# for adb
export PATH="$PATH:$ANDROID_HOME/platform-tools"
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
  # to find your crtc number use xrandr --verbose, something like HDMI-0, LVDS1
  xrandr --auto
  xrandr --output ${CRTC:DFP1} --brightness ${1:-0.5}
  # when error is xrandr: Need crtc to set gamma on.
  # sudo apt-get install xbackligh
  # xbacklight -dec 2 # or -inc %
}
alias dim=d

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
