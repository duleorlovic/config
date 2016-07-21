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

ionic_publish(){
  if [ -f ~/config/keys/my-release-key.keystore ]
  then
    target_file=${1:-platforms/android/build/outputs/apk/android-release-unsigned.apk}
    echo using target_file $target_file
    jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore ~/config/keys/my-release-key.keystore $target_file alias_name # this will change the file inline
    $ANDROID_HOME/build-tools/21.1.2/zipalign -v 4 $target_file my_app.apk
  else
    echo You need to create keys in ~/config/keys/my-release-key.keystore
    echo keytool -genkey -v -keystore ~/config/keys/my-release-key.keystore -alias alias_name -keyalg RSA -keysize 2048 -validity 10000
  fi
}

ionic_find_package_name(){
  if [ -z $1 ]
  then
    echo Default apk file is: my_app.apk
  fi
  apk_file=${1:-my_app.apk}
  if [ -f $apk_file ]
  then
    $ANDROID_HOME/build-tools/21.1.2/aapt dump badging $apk_file | sed -n "s/package: name='\(\S*\)'.*/\1/p"

  else
    echo Can not find $apk_file
  fi
}

# copy line to clipboard
bind '"\C-l": "\C-e\C-u xsel --clipboard <<"EOF"\n\C-y\nEOF\n\C-y"'
