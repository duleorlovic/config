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
  ~/config/bashrc/get_current_viewport.sh
  ~/config/bashrc/ionic.sh
  ~/config/bashrc/rails.sh
  ~/config/bashrc/arduino.sh
  ~/config/bashrc/common_functions.sh
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
export ANDROID_SDK_HOME=$ANDROID_HOME
# issue with unable to load driver https://stackoverflow.com/questions/35911302/cannot-launch-emulator-on-linux-ubuntu-15-10/36625175#36625175
export ANDROID_EMULATOR_USE_SYSTEM_LIBS=1
# for emulator command
export PATH="$PATH:$ANDROID_HOME/emulator"
# for android command
export PATH="$PATH:$ANDROID_HOME/tools"
# for adb
export PATH="$PATH:$ANDROID_HOME/platform-tools"
# for genymotion
export PATH="$PATH:$HOME/Programs/genymotion"
# for studio.sh
export PATH="$PATH:$HOME/Programs/android-studio/bin"
# for gradle
export PATH="$PATH:$HOME/Programs/gradle/bin"
# for glass
export PATH="$PATH:$HOME/Programs/glass"
# for my scripts
export PATH="$PATH:$HOME/config/bin"

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
    Add -s to source keys instead of edit
    Add -ss to source keys and server script
	HERE_DOC
    return
  fi
  current_path=$(pwd)
  projectName=`basename $current_path`
  if [ -f ~/config/keys/$projectName.sh ];then
    if [ "$1" == "-s" ]; then
      echo_red source ~/config/keys/$projectName.sh
      source ~/config/keys/$projectName.sh
    elif [ "$1" == "-ss" ]; then
      echo_red source ~/config/keys/$projectName.server.sh
      source ~/config/keys/$projectName.server.sh
    else
      echo_red vi ~/config/keys/$projectName.sh
      vi ~/config/keys/$projectName.sh
    fi
  else
    echo_red can not find ~/config/keys/$projectName.sh
  fi
}

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=critical -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias g=git
# https://brbsix.github.io/2015/11/23/perform-tab-completion-for-aliases-in-bash/
_completion_loader git
complete -o bashdefault -o default -o nospace -F _git g

alias be='bundle exec'

# http://dokku.viewdocs.io/dokku/community/clients/
alias dokku='$HOME/.dokku/contrib/dokku_client.sh'

# add bin to path, but only for project where you  run mkdir -p .git/safe
PATH=".git/safe/../../bin:$PATH"

# https://github.com/titusfortner/webdrivers
# export PATH="$HOME/.webdrivers:$PATH"
export DISPLAY=":0.0"
