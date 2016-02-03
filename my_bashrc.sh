MY_FILES=(
  ~/config/keys/my_keys.sh
  ~/config/bashrc/window_shortcuts.sh
)

for my_file in ${MY_FILES[*]}; do
  if [ -f $my_file ]; then
    source $my_file
  fi
done

if [ "`pgrep dbus-monitor`" == "" ];then
  echo Starting screenlock_hooks
  /home/orlovic/config/bashrc/screenlock_hooks.sh
fi

export EDITOR=vim

# Add Android SDK tools to PATH
export ANDROID_HOME=/home/orlovic/Android/Sdk/
export PATH="$PATH:$HOME/Android/Sdk/tools"
export SECRET_KEY_BASE=123asd

function d {
  if [  -z $1 ]
  then
    echo Default is middle value: d 0.5
  fi
  xrandr --output DFP1 --brightness ${1:-0.5}
}
alias dim=d

last_migration(){
  vim db/migrate/$(ls db/migrate/ | sort | tail -1)
}
