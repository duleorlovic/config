function is_mac_os {
  if [ "$(uname)" == "Darwin" ]; then
    # 0 is true
    return 0
  else
    # 1 is false
    return 1
  fi
}

MY_FILES=(
  ~/config/keys/my_keys.sh
  ~/config/bashrc/ionic.sh
  ~/config/bashrc/rails.sh
)

for my_file in ${MY_FILES[*]}; do
  if [ -f $my_file ]; then
    source $my_file
  fi
done

if is_mac_os; then
  source ~/config/bashrc/mac_scripts/mac_window_shortcuts.sh
else
  source ~/config/bashrc/window_shortcuts.sh
fi

# if [ "`pgrep dbus-monitor`" == "" ];then
#   echo Starting monitor_lock_hooks
#   /home/orlovic/config/bashrc/monitor_lock_hooks.sh
# fi

export EDITOR=vim

# Add Android SDK tools to PATH
export ANDROID_HOME=/media/orlovic/bf12a7e5-a5d4-4532-8612-a3984f90b56c/shared/Android/Sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME
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
# for glass
export PATH="$PATH:$HOME/Programs/glass"

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
if is_mac_os; then
  bind '"\C-l": "\C-e\C-u pbcopy <<"EOF"\n\C-y\nEOF\n\C-y"'
else
  bind '"\C-l": "\C-e\C-u xsel --clipboard <<"EOF"\n\C-y\nEOF\n\C-y"'
fi

function echo_red {
  tput setaf 1
  echo $@
  tput sgr0
}

function echo_and_run {
  echo_red $@
  $@
}

function keys {
  if [ "$1" == "-h" ]; then
    cat <<-HERE_DOC
    Edit keys for current project, if exists.
    Add -s to source them after edit
	HERE_DOC
    return
  fi
  current_path=$(pwd)
  projectName=`basename $current_path`
  if [ -f ~/config/keys/$projectName.sh ];then
    if [ "$1" == "-s" ] || [ "$1" == "-r" ]; then
      echo_red edit and source ~/config/keys/$projectName.sh
      vi ~/config/keys/$projectName.sh
      source ~/config/keys/$projectName.sh
    else
      echo_red edit ~/config/keys/$projectName.sh
      vi ~/config/keys/$projectName.sh
    fi
  else
    echo_red can not find ~/config/keys/$projectName.sh
  fi
}
