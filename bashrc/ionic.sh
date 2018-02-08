# /bin/bash -x
#
# Some ionic helpers
#

ionic_publish(){
  tput setaf 1
  default_keystore_file=~/config/keys/my-release-key.keystore
  if [ "$1" == "-h" ]; then
    cat <<-HERE_DOC
    Hi, this function that package the apk
    Params are:
    your-key.keystore (default is config/keys/my-release-key.keystore)
    jar_password (default is $JAR_PASSWORD)
    unsigned.apk (default is platforms/android/build/outputs/apk/android-release-unsigned.apk)
	HERE_DOC
    return
  fi
  if [ -z $1 ]
  then
    echo Default keystore is: $default_keystore_file
  fi
  keystore_file=${1:-$default_keystore_file}
  if [ -f $keystore_file ]
  then
    echo_and_run cordova build --release android
    jar_password=${2:-$JAR_PASSWORD}
    target_file=${3:-platforms/android/build/outputs/apk/android-release-unsigned.apk}
    echo_red using target_file $target_file
    if [ -f my_app.apk ]
    then
      echo_and_run mv my_app.apk ~/Downloads
    fi
    echo_red it might ask you for a password to use your key
    if echo $jar_password | jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $keystore_file $target_file alias_name # this will change the file inline
    then
      echo_red signed successfully
      echo_and_run $ANDROID_HOME/build-tools/21.1.2/zipalign -v 4 $target_file my_app.apk
      echo_red my_app.apk stored in current folder
      echo_and_run adb -d uninstall `ionic_find_package_name my_app.apk`
      echo_and_run adb -d install my_app.apk
      echo_and_run adb -d shell am start -a android.intent.action.MAIN -n `ionic_find_package_name my_app.apk`/.MainActivity
    else
      echo_red failed to sign $target_file
    fi
  else
    echo_red You need to create keys in $keystore_file
    echo_red keytool -genkey -v -keystore $keystore_file -alias alias_name -keyalg RSA -keysize 2048 -validity 10000
  fi
  echo_red bye
}

ionic_install(){
  if [ -z $1 ]
  then
    echo Default apk file is: my_app.apk
  fi
  apk_file=${1:-my_app.apk}
  if [ -f $apk_file ]
  then
   echo_and_run adb -d uninstall `ionic_find_package_name $apk_file`
   echo_and_run adb -d install $apk_file
   echo_and_run adb -d shell am start -a android.intent.action.MAIN -n `ionic_find_package_name $apk_file`/.MainActivity
  else
    echo Can not find $apk_file
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
    $ANDROID_HOME/build-tools/25.0.3/aapt dump badging $apk_file | sed -n "s/package: name='\(\S*\)'.*/\1/p"

  else
    echo Can not find $apk_file
  fi
}

ionic_log(){
  if [ "$1" == "-h" ]; then
    cat <<-HERE_DOC
    Hi, this function show log from android device connected with usb
    use -d (default) or -e option, for log from device or emulator
	HERE_DOC
    return
  fi
  if [ "$1" == "-e" ]; then
    target=e
  else
    target=d
  fi
  # old android use we console, new android use chromium
  echo_and_run adb -$target logcat | grep 'chromium\|Web Console'
}

ionic_push_hosts() {
  if [ "$1" == "-h" ]; then
    cat <<-HERE_DOC
    Hi, this function that will remount and push hosts file to android emulator
    Params are:
    emulator_name (default is googleapi21)
    host_file (default is ./hosts)
	HERE_DOC
    return
  fi
  emulator_name=${1-googleapi21}
  hosts_file=${2-hosts}
  echo_and_run emulator -avd $emulator_name -partition-size 512 &
  echo_and_run adb -e wait-for-device
  echo_and_run adb -e remount
  echo_and_run adb -e push hosts /system/etc
  echo_and_run adb -e shell cat /etc/hosts
}
